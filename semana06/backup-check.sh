#!/bin/bash

# backup-check.sh - Validador de backups
# Uso: ./backup-check.sh [directorio_backup]
#
# Verifica existencia, antiguedad y tamanio de backups.
# Genera un log con el resultado de cada verificacion.

# === Constantes configurables ===
readonly VERSION="1.0.0"
readonly DIR_BACKUP="${1:-/backup}"
readonly DIR_LOGS="$(dirname "$0")/logs"
readonly LOGFILE="$DIR_LOGS/backup-check-$(date +%Y%m%d).log"
readonly MAX_HORAS_SIN_BACKUP=24	# alertar si el backup es mas viejo
readonly MIN_TAMANIO_MB=10		# alertar si el backup es mas pequenio
readonly MAX_TAMANIO_MB=50000		# alertar si el backup es muy grande

# === Variables de estado global ===
estado_global="OK"

# === Funcion de uso ===
uso() {
	echo "Uso: $0 [directorio_backup]"
	echo ""
	echo "	directorio_backup 	Directorio a verificar"
	echo "				(por defecto: /backup)"
	echo ""
	echo "Opciones:"
	echo "	--version 		Version del script"
	echo "	--help 			Esta ayuda"
	echo ""
	echo "Ejemplos:"
	echo "	$0"
	echo "	$0 /mnt/respaldo"
	echo "	$0 ~/backup-prueba"
	exit 2
}

# === Funcion de logging ===
# Uso: log NIVEL "mensaje"
log() {
   local nivel="$1"
   local mensaje="$2"
   local timestamp
   timestamp=$(date '+%Y-%m-%d %H:%M:%S')

   printf "[%s] [%-7s] %s\n" "$timestamp" "$nivel" "$mensaje" | tee -a "$LOGFILE"

   # Actualizar el estado global si el nivel es grave
   if [ "$nivel" = "ERROR" ] && [ "$estado_global" != "ERROR" ]; then
	estado_global="ERROR"
   elif [ "$nivel" = "WARNING" ] && [ "$estado_global" = "OK" ]; then
	estado_global="WARNING"
   fi
}

# === Procesar argumentos especiales ===
case "${1:-}" in
   --version) echo "backup-check.sh v$VERSION"; exit 0 ;;
   --help|-h) uso ;;
esac

# Asegurar que el directorio de logs existe
mkdir -p "$DIR_LOGS"
