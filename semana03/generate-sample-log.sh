#!/bin/bash

# Genera un archivo sample.log con 500 entradas
OUTPUT="sample.log"
echo "Generando $OUTPUT..."

# Limpiar archivo si existe
> "$OUTPUT"

SEVERIDADES=("INFO" "INFO" "INFO" "WARNING" "ERROR" "FATAL")
IPS=("192.168.1.10" "192.168.1.25" "10.0.0.5"
     "172.16.0.3" "192.168.1.10" "10.0.0.99"
     "192.168.1.10" "203.0.113.42" "10.0.0.5")

MENSAJES_ERROR=(
    "Connection timeout after 30 s"
    "Failed to write to disk"
    "Authentication failed for user admin"
    "Database connection refused"
    "Out of memory error in module X"
    "Connection timeout after 30 s"
    "Authentication failed for user admin"
    "Connection timeout after 30 s"
)

MENSAJES_INFO=(
    "User login successful"
    "Request processed in 120ms"
    "Cache refreshed"
    "Backup completed"
    "Service started"
    "Health check passed"
)

MENSAJES_WARNING=(
    "Disk usage above 80 percent"
    "High CPU usage detected "
    "Slow query detected"
    "Certificate expires in 30 days"
)

for i in $(seq 1 500); do
    HORA=$(printf "%02d" $((RANDOM % 24)))
    MIN=$(printf "%02d" $((RANDOM % 60)))
    SEG=$(printf "%02d" $((RANDOM % 60)))
    FECHA="2026-02-15 $HORA:$MIN:$SEG"
   
    IP=${IPS[$((RANDOM % ${#IPS[@]}))]}
    SEV=${SEVERIDADES[$((RANDOM % ${#SEVERIDADES[@]}))]}

    case "$SEV" in
    "ERROR"|"FATAL")
       MSG=${MENSAJES_ERROR[$((RANDOM % ${#MENSAJES_ERROR[@]}))]}
       ;;
    "WARNING")
       MSG=${MENSAJES_WARNING[$((RANDOM % ${#MENSAJES_WARNING[@]}))]}
       ;;
    *)
       MSG=${MENSAJES_INFO[$((RANDOM % ${#MENSAJES_INFO[@]}))]}
       ;;
    esac

    echo "$FECHA | $IP | $SEV | $MSG" >> "$OUTPUT"
done

echo "         Generadas 500 entradas en $OUTPUT"
echo "   Lineas: $(wc -l < "$OUTPUT")"
echo "   Errores: $(grep -Ec "ERROR|FATAL" "$OUTPUT")"
