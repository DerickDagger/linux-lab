#!/bin/bash
# lib/procesos.sh - Funciones de inspeccion de procesos

# Lista los N procesos con mayor uso de CPU
listar_top_cpu() {
    local n="${1:-5}"
    echo "--- Top ${n} procesos por CPU ---"
    ps aux --sort=-%cpu | awk -v n="$n" 'NR>1 && NR<=n+1 {printf "%-8s PID:%-6s CPU:%5s%% MEM:%5s%% %s\n", $1, $2, $3, $4, $11}'
}

# Lista los N procesos con mayor uso de memoria
listar_top_mem() {
    local n="${1:-5}"
    echo "--- Top ${n} procesos por MEM ---"
    ps aux --sort=-%mem | awk -v n="$n" 'NR>1 && NR<=n+1 {printf "%-8s PID:%-6s CPU:%5s%% MEM:%5s%% %s\n", $1, $2, $3, $4, $11}'
}

# Detecta procesos zombie
detectar_zombies() {
    echo "--- Procesos zombie ---"
    local zombies
    zombies=$(ps -eo pid,ppid,stat,comm | awk '$3 ~ /Z/ { print }')
    if [[ -z "$zombies" ]]; then
        echo "Ninguno detectado"
    else
        echo "$zombies" | while read -r pid ppid stat comm; do
            printf "PID:%-6s PPID:%-6s CMD:%s\n" "$pid" "$ppid" "$comm"
        done
    fi
}
# Verifica si un proceso esta activo
verificar_proceso() {
    local nombre="$1"
    if pgrep -x "$nombre" > /dev/null 2>&1; then
        local pid
        pid=$(pgrep -x "$nombre" | head -1)
        log "OK" "Proceso '$nombre' activo (PID: $pid)"
        return 0
    else
        log "WARNING" "Proceso '$nombre' no encontrado"
        return 1
    fi
}

# Muestra el arbol de procesos de un usuario
arbol_usuario() {
    local usuario="${1:-$USER}"
    echo "--- Árbol de procesos de '$usuario' ---"
    pstree -p "$usuario" 2>/dev/null || ps -u "$usuario" --forest -o pid,stat,comm 2>/dev/null
}
