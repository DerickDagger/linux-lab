#!/bin/bash
set -euo pipefail

REPO="${1:-$HOME/linux-lab}"

if [[ ! -d "$REPO" ]]; then
    echo "Error: directorio '$REPO' no existe." >&2
    exit 1
fi

echo "Analizando repositorio: $REPO"
# --- 1. Cargar lista de archivos ---
mapfile -t archivos < <(find "$REPO" -type f | sort)
echo "Total de archivos encontrados: ${#archivos[@]}"
