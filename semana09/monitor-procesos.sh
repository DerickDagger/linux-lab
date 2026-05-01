#!/bin/bash
# monitor-procesos.sh
# Monitorea procesos del sistema y genera reporte
# Uso: ./monitor-procesos.sh [-u usuario] [-t umbral] [-k] [-r archivo]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/lib/alertas.sh"
source "${SCRIPT_DIR}/lib/procesos.sh"

# Valores por defecto
USUARIO="${USER}"
UMBRAL_CPU=50
MATAR=false
REPORTE="reportes/reporte-$(date '+%Y%m%d-%H%M%S').txt"
PROCESOS_VIGILAR=()

uso() {
    echo "Uso: $0 [opciones] [proceso1 proceso2...]"
    echo ""
    echo "Opciones:"
    echo "  -u USUARIO    Usuario a inspeccionar (default: actual)"
    echo "  -t UMBRAL     % CPU para alertar (default: 50)"
    echo "  -k            Enviar SIGTERM a procesos sobre el umbral"
    echo "  -r ARCHIVO    Guardar reporte en archivo especifico"
    echo "  -h            Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 nginx mysql"
    echo "  $0 -u usuario -t 80 -k"
    echo "  $0 -r /tmp/mi-reporte.txt nginx"
}

# Parsear argumentos con getopts
while getopts "u:t:r:kh" opt; do
    case "$opt" in
        u) USUARIO="$OPTARG" ;;
        t) UMBRAL_CPU="$OPTARG" ;;
        r) REPORTE="$OPTARG" ;;
        k) MATAR=true ;;
        h) uso; exit 0 ;;
        *) uso; exit 2 ;;
    esac
done
shift $((OPTIND - 1))

# Procesos adicionales a vigilar (argumentos restantes)
PROCESOS_VIGILAR=("$@")

# Cleanup al salir
trap 'echo "[$(date "+%H:%M:%S")] Monitor finalizado" >> "$LOG_FILE"' EXIT

# === CUERPO PRINCIPAL ===

SEPARADOR="============================================="

{
    echo "$SEPARADOR"
    echo "REPORTE DE PROCESOS - $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Sistema: $(hostname) | Usuario: $USUARIO"
    echo "$SEPARADOR"
    echo ""

    listar_top_cpu 5
    echo ""
    listar_top_mem 5
    echo ""
    detectar_zombies
    echo ""

    if [[ ${#PROCESOS_VIGILAR[@]} -gt 0 ]]; then
        echo "--- Verificando procesos vigilados ---"
        for proc in "${PROCESOS_VIGILAR[@]}"; do
            verificar_proceso "$proc"
        done
        echo ""
    fi

    arbol_usuario "$USUARIO"
    echo ""

    # Detectar procesos sobre el umbral de CPU
    echo "--- Procesos con CPU > ${UMBRAL_CPU}% ---"
    ALTOS=$(ps aux --sort=-%cpu | awk -v u="$UMBRAL_CPU" \
    'NR > 1 && $3+0 > u { print $2, $3, $11 }')

    if [[ -z "$ALTOS" ]]; then
        echo "Ninguno sobre el umbral"
    else
        echo "$ALTOS" | while read -r pid cpu cmd; do
            printf "PID:%-6s CPU:%5s%% CMD:%s\n" "$pid" "$cpu" "$cmd"
            if [[ "$MATAR" == true ]]; then
                log "WARNING" "Enviando SIGTERM a PID $pid ($cmd)"
                kill -15 "$pid" 2>/dev/null || true
            fi
        done
    fi

    echo ""
    echo "$SEPARADOR"
    echo "Reporte guardado en: $REPORTE"

} | tee "$REPORTE"

log "INFO" "Reporte generado: $REPORTE"
