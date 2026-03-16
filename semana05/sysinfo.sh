#!/bin/bash

# sysinfo.sh - Reporte del estado del sistema
# Uso: ./sysinfo.sh [--all | --cpu | --mem | --disk | --proc]
#
# Sin argumentos muestra el reporte completo.
# Con --seccion muestra solo esa seccion.

# === Constantes ===
readonly VERSION="1.0.0"
readonly SEPARADOR="========================================"
readonly SEPARADOR_SEC="----------------------------------------"

# === Funcion de uso ===
uso() {
	echo "Uso: $0 [opcion]"
	echo ""
	echo "Opciones:"
	echo "	(sin args)	Reporte completo"
	echo "	--all		Reporte completo (explicito)"
	echo "	--cpu		Solo CPU"
	echo "	--mem 		Solo memoria"
	echo "	--disk 		Solo disco"
	echo "	--proc 		Solo procesos"
	echo "	--version 	Version del script"
	echo "	--help 		Esta ayuda"
	echo ""
	echo "Ejemplos:"
	echo "	$0"
	echo "	$0 --mem"
	echo "	$0 --disk"
	exit 2
}

# === Procesar argumentos ===
MODO="${1:-all}"

case "$MODO" in
	--all|"all") 	MODO="all"	;;
	--cpu) 		MODO="cpu"	;;
	--mem) 		MODO="mem" 	;;
	--disk) 	MODO="disk"	;;
	--proc)	 	MODO="proc"	;;
	--version)	echo "sysinfo.sh version $VERSION";
	exit 0 ;;
	--help|-h) 	uso ;;
	*)
	echo " Error: opcion desconocida '$MODO'"
	uso
	;;
esac

echo "$SEPARADOR"
printf "REPORTE DEL SISTEMA - sysinfo.sh v%s\n" "$VERSION"
echo "$SEPARADOR"
echo ""

# === Seccion 1: Informacion general ===
seccion_general() {
	echo "[ INFORMACION DEL SISTEMA ]"
	echo "$SEPARADOR_SEC"
	printf "  %-18s %s\n" "Hostname:" 	"$(hostname)"
	printf "  %-18s %s\n" "Usuario:" 	"$USER"
	printf "  %-18s %s\n" "Sistema:" 	"$(uname -s)"
	printf "  %-18s %s\n" "Kernel:" 	"$(uname -r)"
	printf "  %-18s %s\n" "Arquitectura:" 	"$(uname -m)"
	printf "  %-18s %s\n" "Fecha/Hora:" 	"$(date '+%d/%m/%Y %H:%M:%S')"
	printf "  %-18s %s\n" "Encendido:" 	"$(uptime -p)"
	echo ""
}

# === Seccion 2: CPU ===
seccion_cpu() {
	echo "[ CPU ]"
	echo "$SEPARADOR_SEC"
	nucleos=$(nproc)
	carga=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | tr -d ',')
	printf "  %-18s %s\n" "Nucleos:" 	"$nucleos"
	printf "  %-18s %s\n" "Carga (1 min):" 	"$carga"
	echo ""
}

# === Seccion 3: Memoria RAM ===
seccion_memoria() {
	echo "[ MEMORIA RAM ]"
	echo "$SEPARADOR_SEC"
	mem_total=$(free -h | awk '/^Mem:/ {print $2}')
	mem_usado=$(free -h | awk '/^Mem:/ {print $3}')
	mem_libre=$(free -h | awk '/^Mem:/ {print $4}')
	swap_total=$(free -h | awk '/^Swap:/ {print $2}')
	swap_usado=$(free -h | awk '/^Swap:/ {print $3}')

	printf "  %-18s %s\n" "RAM total:" 	"$mem_total"
	printf "  %-18s %s\n" "RAM usada:" 	"$mem_usado"
	printf "  %-18s %s\n" "RAM libre:" 	"$mem_libre"
	printf "  %-18s %s\n" "Swap total:" 	"$swap_total"
	printf "  %-18s %s\n" "Swap usado:" 	"$swap_usado"
	echo ""
}

# === Seccion 4: Disco ===
seccion_disco() {
	echo "[ USO DE DISCO ]"
	echo "$SEPARADOR_SEC"
	printf "  %-20s %6s %6s %6s %5s\n" "Particion" "Total" "Usado" "Libre" "Uso%"
	echo "$(printf '%.0s-' {1..48})"
	df -h | grep -v "^tmpfs\|^udev\|^Filesystem" | \
	     awk '{printf "  %-20s %6s %6s %6s %5s\n", $6, $2, $3, $4, $5}'
	echo ""
}

# === Ejecutar segun el modo ===
case "$MODO" in
   all)
	seccion_general
	seccion_cpu
	seccion_memoria
	seccion_disco
	;;
   disk) seccion_disco ;;
   cpu) seccion_cpu ;;
   mem) seccion_memoria ;;
esac
