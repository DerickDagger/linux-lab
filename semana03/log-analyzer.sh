#!/bin/bash

#log-analyzer.sh
#Analizador de logs del sistema
#Uso: ./log-analyzer.sh [archivo.log]

set -e

LOGFILE="${1:-sample.log}"

# Verificar que el archivo existe
if [ ! -f "$LOGFILE" ]; then
   echo "Error: El archivo ’$LOGFILE’ no existe."
   echo "Uso: $0 [archivo.log]"
   exit 1
fi

echo "=============================="
echo "	 ANALIZADOR DE LOGS"
echo "=============================="
echo "Archivo: $LOGFILE"
echo "Entradas: $(wc -l < "$LOGFILE")"
echo "=============================="
echo ""
