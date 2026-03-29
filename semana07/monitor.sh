#!/bin/bash

# monitor.sh - Monitor de recursos del sistema
# Uso: ./monitor.sh [--intervalo N] [--max N]
#		    [--umbral-disco N] [--umbral-ram N]

readonly VERSION="1.0.0"
readonly LOGFILE="monitor.log"

UMBRAL_DISCO=80
UMBRAL_RAM=85
INTERVALO=10
MAX_ITER=0 	# 0 = sin limite

uso() {
    echo "Uso: $0 [opciones]"
    echo " "
    echo "   --intervalo N	Segundos entre comprobaciones"
    echo "   --max N		Max. iteraciones (0= sin limite)"
    echo "   --umbral-disco N	Alerta de disco en %"
    echo "   --umbral-ram N	Alerta de RAM en %"
    echo "   --version		Version del script"
    echo " "
    echo "Ejemplos:"
    echo "   $0 --intervalo 5 --max 12"
    echo "   $0 --umbral-disco 70"
    exit 2
}

# Retorna el porcentaje de uso de la particion raiz
uso_disco() {
    df / | awk 'NR==2 {gsub(/%/,"",$5); print $5}'
}

# Retorna el porcentaje de RAM usada
uso_ram() {
    free | awk '/^Mem:/ {
	printf "%.0f", ($3/$2) * 100
    }'
}

# Retorna el load average del ultimo minuto
carga_cpu() {
    LC_ALL=C uptime | awk -F'load average:' '{print $2}' | awk '{gsub(/,/,"",$1); print $1}'
}

# Escribe al log y a pantalla con marca de tiempo
registrar() {
    local nivel="$1"
    local mensaje="$2"
    local ts
    ts=$(date '+%Y-%m-%d %H:%M:%S')
    printf "[%s] [%-7s] %s\n" \
	"$ts" "$nivel" "$mensaje" | tee -a "$LOGFILE"
}

resumen_log() {
    echo ""
    echo "==========================================="
    echo "           RESUMEN DE LA SESIÓN"
    echo "==========================================="
    local total alertas
    total=$(grep -c "\[ INFO	\]" "$LOGFILE" 2>/dev/null || echo 0)
    alertas=$(grep -c "\[ ALERTA \]" "$LOGFILE" 2>/dev/null || echo 0)

    printf "%-25s %d\n" "Comprobaciones totales:" "$total"
    printf "%-25s %d\n" "Alertas emitidas:" "$alertas"
    echo ""
    echo "Últimas entradas:"

    # Leer el log con while y mostrar las últimas 3 líneas
    tail -3 "$LOGFILE" | while IFS= read -r linea; do
        echo "	  $linea"
    done
    echo "==========================================="
}

# Procesar argumentos con while
while [ $# -gt 0 ]; do
    case "$1" in
	--intervalo)	INTERVALO="$2";    shift 2 ;;
	--max)		MAX_ITER="$2";     shift 2 ;;
	--umbral-disco)	UMBRAL_DISCO="$2"; shift 2 ;;
	--umbral-ram)	UMBRAL_RAM="$2";   shift 2 ;;
	--version) echo "monitor.sh v$VERSION"; exit 0 ;;
	--help|-h) uso ;;
	*) echo "Opcion desconocida: $1"; uso ;;
    esac
done

# Manejo de Ctrl+C: mostrar resumen antes de salir
trap 'echo "";
      registrar "INFO" "Monitor detenido por el usuario.";
      exit 0' INT

registrar "INFO" "Iniciando monitor intervalo: ${INTERVALO}s"
registrar "INFO" "Umbrales: disco=${UMBRAL_DISCO}% RAM=${UMBRAL_RAM}%"

iteracion=0

while true; do
    iteracion=$((iteracion + 1))

    # Salir si se alcanzo el limite de iteraciones
    if [ "$MAX_ITER" -gt 0 ] && [ "$iteracion" -gt "$MAX_ITER" ]; then
        registrar "INFO" "Limite de $MAX_ITER iteraciones alcanzado."
        break
    fi

    disco=$(uso_disco)
    ram=$(uso_ram)
    cpu=$(carga_cpu)

    registrar "INFO" "Disco: ${disco}% RAM: ${ram}% CPU-load: ${cpu}"

    [ "$disco" -ge "$UMBRAL_DISCO" ] && registrar "ALERTA" "Disco al ${disco}% (umbral: ${UMBRAL_DISCO}%)"

    [ "$ram" -ge "$UMBRAL_RAM" ] && registrar "ALERTA" "RAM al ${ram}% (umbral: ${UMBRAL_RAM}%)"

    sleep "$INTERVALO"
done
