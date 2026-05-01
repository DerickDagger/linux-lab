#!/bin/bash
# install-dev-stack.sh
# Instala y configura el dev stack del curso Linux
# Uso: sudo ./install-dev-stack.sh [--dry-run] [--verbose]

set -euo pipefail

# === CONSTANTES ===
readonly VERSION="1.0.0"
readonly LOG_FILE="install.log"
readonly TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# === COLORES ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

# === FLAGS ===
DRY_RUN=false
VERBOSE=false

# === ESTADO ===
PAQUETES_INSTALADOS=()
PAQUETES_OMITIDOS=()
ERRORES=0

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run) DRY_RUN=true ;;
        --verbose) VERBOSE=true ;;
        --help|-h)
            echo "Uso: $0 [--dry-run] [--verbose]"
            echo " --dry-run   Mostrar que haria sin ejecutar"
            echo " --verbose   Salida detallada"
            exit 0
            ;;
        *) echo "Opcion desconocida: $1"; exit 1 ;;
    esac
    shift
done

# === FUNCIONES DE LOG ===
log() {
    local nivel=$1; shift
    local mensaje="$*"
    local linea="[$TIMESTAMP] [$nivel] $mensaje"
    echo "$linea" >> "$LOG_FILE"
    case $nivel in
        INFO)  echo -e "${BLUE}[INFO]${NC} $mensaje" ;;
        OK)    echo -e "${GREEN}[OK]${NC} $mensaje" ;;
        WARN)  echo -e "${YELLOW}[WARN]${NC} $mensaje" ;;
        ERROR) echo -e "${RED}[ERROR]${NC} $mensaje" ;;
        STEP)  echo -e "\n${BLUE}===== $mensaje =====${NC}" ;;
    esac
}

echo "Dev Stack Installer v$VERSION" > "$LOG_FILE"
echo "Iniciado: $TIMESTAMP" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

# === DETECCION DE OS ===
detectar_os() {
    log STEP "Detectando sistema operativo"
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        OS_ID=$ID
        OS_VERSION=$VERSION_ID
        OS_NAME=$PRETTY_NAME
    else
        log ERROR "No se puede detectar el OS (/etc/os-release no existe)"
        exit 1
    fi

    case $OS_ID in
        ubuntu|debian|linuxmint|pop)
            PKG_UPDATE="apt update -qq"
            PKG_INSTALL="apt install -y"
            PKG_CHECK="dpkg -l"
	    log OK "OS soportado: $OS_NAME"
            ;;
        *)
        fedora|rhel|centos|rocky)
            PKG_UPDATE="dnf check-update -q || true"
            PKG_INSTALL="dnf install -y"
            PKG_CHECK="rpm -q"
	    log WARN "OS Red Hat detectado. Algunos paquetes pueden diferir."
            ;;
        *)
            log ERROR "OS no soportado: $OS_ID"
            log INFO "Soportados: ubuntu, debian, linuxmint, fedora, rhel"
            exit 1
            ;;
    esac
}
