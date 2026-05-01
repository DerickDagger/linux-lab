#!/bin/bash
# verify-install.sh - Verifica que el dev stack este instalado

set -uo pipefail

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

TOTAL=0
OK=0
FAIL=0

verificar_comando() {
    local nombre=$1
    local cmd=$2
    local flag=${3:---version}
    TOTAL=$((TOTAL + 1))

    if command -v "$cmd" &>/dev/null; then
        local ver
        ver=$("$cmd" $flag 2>&1 | head -1 | cut -c1-60)
        echo -e "${GREEN}[OK]${NC} $nombre"
        echo -e "   $ver"
        OK=$((OK + 1))
    else
        echo -e "${RED}[FAIL]${NC} $nombre: no encontrado"
        FAIL=$((FAIL + 1))
    fi
}

verificar_paquete_deb() {
    local nombre=$1
    local pkg=$2
    TOTAL=$((TOTAL + 1))

    if dpkg -l "$pkg" &>/dev/null 2>&1; then
        local ver
        ver=$(dpkg -l "$pkg" | grep "^ii" | awk '{print $3}')
        echo -e "${GREEN}[OK]${NC} $nombre (v$ver)"
        OK=$((OK + 1))
    else
        echo -e "${RED}[FAIL]${NC} $nombre ($pkg): no instalado"
        FAIL=$((FAIL + 1))
    fi
}

echo ""
echo "==========================================================="
echo "               VERIFICACION DEL DEV STACK"
echo "               $(date '+%Y-%m-%d %H:%M:%S')"
echo "==========================================================="

echo ""
echo "--- Herramientas esenciales ---"
verificar_comando "Git" 	git     "--version"
verificar_comando "curl"	curl    "--version"
verificar_comando "wget" 	wget    "--version"
verificar_comando "vim" 	vim     "--version"
verificar_comando "tree" 	tree    "--version"
verificar_comando "htop"	htop    "--version"
verificar_comando "jq" 		jq      "--version"

echo ""
echo "--- Entorno de desarrollo ---"
verificar_comando "Python 3"    python3 "--version"
verificar_comando "pip3" 	pip3    "--version"
verificar_paquete_deb "build-essential" "build-essential"

echo ""
echo "--- Utilidades de sistema ---"
verificar_comando "unzip" 	unzip 	"-v"
verificar_comando "tmux" 	tmux 	"-V"
verificar_comando "shellcheck"  shellcheck "--version"

echo ""
echo "--- Red ---"
verificar_comando "netstat" 	netstat "--version"
verificar_comando "ping" 	ping 	"-V"
verificar_comando "ss" 		ss 	"-V"

echo ""
echo "==========================================================="
PORCENTAJE=$((OK * 100 / TOTAL))
echo "	RESULTADO: $OK / $TOTAL herramientas OK ($PORCENTAJE%)"
if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}Estado: COMPLETO${NC}"
else
    echo -e "${YELLOW}Estado: $FAIL herramientas faltantes${NC}"
    echo "Ejecuta: sudo ./install-dev-stack.sh"
fi
echo "==========================================================="

# Guardar reporte
{
    echo "# Reporte de Verificacion"
    echo "Fecha: $(date)"
    echo "Herramientas OK: $OK / $TOTAL"
    echo "Estado: $([ $FAIL -eq 0 ] && echo 'COMPLETO' || echo 'INCOMPLETO')"
} > verification-report.md

exit $FAIL
