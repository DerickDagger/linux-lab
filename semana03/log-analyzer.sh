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

# [1/5] Top 10 direcciones IP
echo "[1/5] TOP 10 DIRECCIONES IP"
echo "------------------------------"
# Extraer la columna de IP (campo 2, separador |)
# Ordenar, contar y mostrar las 10 m s frecuentes
cut -d'|' -f2 "$LOGFILE" | \
   tr -d ' ' | \
   sort | \
   uniq -c | \
   sort -rn | \
   head -10 | \
   awk '{printf "  %5d solicitudes -> %s\n", $1, $2}'
echo ""
