#!/bin/bash
# install-dev-stack.sh
# Instala y configura el dev stack del curso Linux
# Uso: sudo ./install-dev-stack.sh [--dry-run] [--verbose]

set -euo pipefail

# === CONSTANTES ===
readonly SCRIPT_VERSION="1.0.0"
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

echo "Dev Stack Installer v$SCRIPT_VERSION" > "$LOG_FILE"
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

    log INFO "OS: $OS_ID | Version: $OS_VERSION"
}

# === ROLLBACK ===
rollback() {
    local exit_code=$?
    if [ $exit_code -ne 0 ] && [ ${#PAQUETES_INSTALADOS[@]} -gt 0 ]; then
        log WARN "Error detectado. Iniciando rollback..."
        sudo apt purge -y "${PAQUETES_INSTALADOS[@]}" 2>/dev/null || true
        sudo apt autoremove -y 2>/dev/null || true
        log OK "Rollback completado. Paquetes revertidos: ${PAQUETES_INSTALADOS[*]}"
    fi
}
trap rollback EXIT

# === INSTALACION ===
instalar_paquete() {
    local paquete=$1
    local descripcion=${2:-$paquete}

    if $DRY_RUN; then
        log INFO "[DRY-RUN] Se instalaria: $paquete"
        return 0
    fi

    if dpkg -l "$paquete" &>/dev/null | grep -q "^ii"; then
        local version
        version=$(dpkg -l "$paquete" | grep "^ii" | awk '{print $3}')
        log OK "$descripcion ya instalado (v$version) -- omitido"
        PAQUETES_OMITIDOS+=("$paquete")
    else
        log INFO "Instalando $descripcion ($paquete)..."
        if sudo $PKG_INSTALL "$paquete" >> "$LOG_FILE" 2>&1; then
            log OK "$descripcion instalado correctamente"
            PAQUETES_INSTALADOS+=("$paquete")
        else
            log ERROR "Fallo al instalar $paquete"
            ERRORES=$((ERRORES + 1))
            return 1
        fi
    fi
}

# === PAQUETES A INSTALAR ===
instalar_dev_stack() {
    log STEP "Actualizando lista de paquetes"
    if ! $DRY_RUN; then
        sudo $PKG_UPDATE >> "$LOG_FILE" 2>&1
        log OK "Lista de paquetes actualizada"
    fi

    log STEP "Instalando herramientas esenciales"
    instalar_paquete "git" 	     "Git (control de versiones)"
    instalar_paquete "curl" 	     "curl (transferencia HTTP)"
    instalar_paquete "wget" 	     "wget (descarga de archivos)"
    instalar_paquete "vim" 	     "Vim (editor de texto)"
    instalar_paquete "tree" 	     "tree (visualizar directorios)"
    instalar_paquete "htop" 	     "htop (monitor de procesos)"
    instalar_paquete "jq" 	     "jq (procesador JSON)"
    instalar_paquete "net-tools"     "net-tools (herramientas de red)"

    log STEP "Instalando entorno de desarrollo"
    instalar_paquete "python3" 	     "Python 3"
    instalar_paquete "python3-pip"   "pip3 (gestor paquetes Python)"
    instalar_paquete "build-essential" "build-essential (compilacion C/C++)"

    log STEP "Instalando utilidades de sistema"
    instalar_paquete "unzip" 	     "unzip"
    instalar_paquete "tmux" 	     "tmux (terminal multiplexer)"
    instalar_paquete "shellcheck"    "ShellCheck (linter Bash)"
}

# === CONFIGURACION POST-INSTALACION ===
configurar_git_global() {
    log STEP "Verificando configuracion de Git"
    if git config --global user.name &>/dev/null; then
        log OK "Git ya configurado: $(git config --global user.name)"
    else
        log WARN "Git no tiene nombre de usuario configurado."
        log INFO "Ejecuta: git config --global user.name 'Tu Nombre'"
        log INFO "Ejecuta: git config --global user.email 'tu@email.com'"
    fi
}

# === RESUMEN FINAL ===
mostrar_resumen() {
    local total_nuevo=${#PAQUETES_INSTALADOS[@]}
    local total_omitido=${#PAQUETES_OMITIDOS[@]}

    echo ""
    echo "=========================================="
    echo "         RESUMEN DE INSTALACION"
    echo "=========================================="
    echo " Nuevos instalados : $total_nuevo"
    echo " Ya existian       : $total_omitido"
    echo " Errores           : $ERRORES"
    echo "=========================================="

    if [ $ERRORES -eq 0 ]; then
        log OK "Instalacion completada exitosamente"
        echo ""
        echo " Ejecuta: ./verify-install.sh"
        echo " Para verificar la instalacion."
    else
        log WARN "Instalacion completada con $ERRORES errores"
        echo " Revisa $LOG_FILE para detalles."
    fi
}

# === MAIN  ===
main() {
    echo ""
    echo "=========================================="
    echo "       DEV STACK INSTALLER v$SCRIPT_VERSION"
    echo "=========================================="
    echo ""

    if [ "$EUID" -ne 0 ]; then
        log ERROR "Este script requiere privilegios root."
        log INFO "Ejecuta: sudo $0"
        exit 1
    fi

    detectar_os
    instalar_dev_stack
    configurar_git_global
    mostrar_resumen
}

main "$@"
