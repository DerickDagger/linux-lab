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
