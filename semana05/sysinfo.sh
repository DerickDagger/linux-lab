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
printf "   REPORTE DEL SISTEMA - sysinfo.sh v%s\n" "$VERSION"
echo "$SEPARADOR"
echo ""
