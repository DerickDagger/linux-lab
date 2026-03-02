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

# [2/5] Distribucion por severidad
echo "[2/5] DISTRIBUCION POR SEVERIDAD"
echo "------------------------------"
TOTAL=$(wc -l < "$LOGFILE")
for nivel in FATAL ERROR WARNING INFO; do
    COUNT=$(grep -c "| $nivel |" "$LOGFILE" 2>/dev/null ||
    echo 0)
    PCT=0
    if [ "$TOTAL" -gt 0 ]; then
	PCT=$(awk "BEGIN {printf \"%.1f\", ($COUNT/$TOTAL) *100}")
    fi
    printf " %-10s %4d entradas (%5s%%)\n" \
	"$nivel" "$COUNT" "$PCT"
done
echo ""

# [3/5] Eventos por hora
echo "[3/5] EVENTOS POR HORA"
echo "------------------------------"
# Extraer la hora (campo 1, luego la hora del timestamp HH:MM:SS)
cut -d'|' -f1 "$LOGFILE" | \
    awk '{print $2}' | \
    cut -d':' -f1 | \
    sort | \
    uniq -c | \
    awk '{printf "  %s:00  %s eventos\n", $2, $1}'
echo ""
