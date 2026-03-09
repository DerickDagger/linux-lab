#!/usr/bin/env bash
# install.sh - Instala los dotfiles en ~/
# Semana 4: Editores y Dotfiles

set -e	 # Detener si hay error

# Directorio donde esta este script
DOTFILES_DIR="$(cd "$(dirname "$0")/dotfiles" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d)"

echo "====================================================================="
echo " 			Instalador de Dotfiles - Semana 4"
echo "====================================================================="
echo "Dotfiles en: $DOTFILES_DIR"
echo ""

# Funcion para instalar un dotfile
instalar() {
    local fuente="$DOTFILES_DIR/$1"
    local destino="$HOME/.$1"	 # Se agrega el punto

    # Verificar que el archivo fuente existe
    if [ ! -f "$fuente" ]; then
        echo "[ERROR] No encontrado: $fuente"
        return 1
    fi

    # Hacer backup si ya existe un archivo real (no symlink)
    if [ -f "$destino" ] && [ ! -L "$destino" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$destino" "$BACKUP_DIR/"
        echo "[BACKUP] $destino      $BACKUP_DIR/"
    fi

    # Eliminar enlace o archivo anterior
    rm -f "$destino"

    # Crear el enlace simbólico
    ln -s "$fuente" "$destino"
    echo "[OK] $destino     $fuente"
}

# Instalar cada dotfile
instalar bashrc
instalar bash_aliases
instalar vimrc

echo ""
echo "Instalación completa."
echo "Para aplicar los cambios ahora, ejecuta:"
echo "  source ~/.bashrc"
