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

# === Verificacion 1: existencia del directorio ===
verificar_directorio() {
   log "INFO" "Verificando directorio: $DIR_BACKUP"

   if [ ! -e "$DIR_BACKUP" ]; then
	log "ERROR" "El directorio '$DIR_BACKUP' no existe."
	return 1
   fi

   if [ ! -d "$DIR_BACKUP" ]; then
	log "ERROR" " '$DIR_BACKUP' existe pero no es un directorio."
	return 1
   fi

   if [ ! -r "$DIR_BACKUP" ]; then
	log "ERROR" "Sin permiso de lectura en '$DIR_BACKUP'."
	return 1
   fi

   log "OK" "Directorio accesible: $DIR_BACKUP"
   return 0
}

# === Procesar argumentos especiales ===
case "${1:-}" in
   --version) echo "backup-check.sh v$VERSION"; exit 0 ;;
   --help|-h) uso ;;
esac

# === Inicio del reporte ===
log "INFO" "=== backup-check.sh v$VERSION - Inicio ==="
log "INFO" "Directorio objetivo: $DIR_BACKUP"

# Ejecutar verificaciones en orden.
# Si el directorio no existe, no tiene sentido continuar.
if ! verificar_directorio; then
   log "ERROR" "Verificacion abortada: directorio inaccesible."
   exit 1
fi
