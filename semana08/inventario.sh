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
# --- 2. Conteo por extension ---
declare -A conteo
declare -A tamano_ext

for f in "${archivos[@]}"; do
    nombre="${f##*/}"
    if [[ "$nombre" == *.* ]]; then
        ext="${nombre##*.}"
    else
        ext="(sin_extension)"
    fi
    conteo["$ext"]=$(( ${conteo["$ext"]:-0} + 1 ))
    bytes=$(stat -c%s "$f" 2>/dev/null || echo 0)
    tamano_ext["$ext"]=$(( ${tamano_ext["$ext"]:-0} + bytes ))
done
# --- 3. Estado de README por semana ---
declare -A tiene_readme
for semana in "$REPO"/semana*/; do
    nombre=$(basename "$semana")
    if [[ -f "$semana/README.md" ]]; then
        tiene_readme["$nombre"]="si"
    else
        tiene_readme["$nombre"]="NO"
    fi
done
# --- 4. Matriz de resumen por semana ---
mapfile -t semanas < <(ls -d "$REPO"/semana*/ 2>/dev/null | sort)
COLS=3    # scripts, docs, tamano_kb
declare -a matriz_sem

for (( i=0; i<${#semanas[@]}; i++ )); do
    dir="${semanas[$i]}"
    scripts=$(find "$dir" -name "*.sh" | wc -l)
    docs=$(find "$dir" -name "*.md"   | wc -l)
    kb=$(du -sk "$dir" 2>/dev/null | awk '{print $1}')
    matriz_sem[$(( i*COLS+0 ))]=$scripts
    matriz_sem[$(( i*COLS+1 ))]=$docs

    matriz_sem[$(( i*COLS+2 ))]=${kb:-0}

done
# --- 5. Mostrar resultados ---
echo ""
echo "=== ARCHIVOS POR EXTENSION ==="
{
    echo "EXTENSION ARCHIVOS TAMANO_KB"
    for ext in $(printf '%s\n' "${!conteo[@]}" | sort); do
        kb=$(( ${tamano_ext["$ext"]:-0} / 1024 ))
        echo "$ext ${conteo[$ext]} $kb"
    done
} | column -t
echo ""
echo "=== RESUMEN POR SEMANA ==="
printf "%-12s %-4s %-4s %-10s %-8s\n" "SEMANA" "SH" "MD" "SIZE_KB" "README"
printf "%s\n" "-----------------------------------------"
for (( i=0; i<${#semanas[@]}; i++ )); do
    nombre=$(basename "${semanas[$i]}")
    printf "%-12s %-4s %-4s %-10s %-8s\n" \
    "$nombre" \
    "${matriz_sem[$(( i*COLS+0 ))]}" \
    "${matriz_sem[$(( i*COLS+1 ))]}" \
    "${matriz_sem[$(( i*COLS+2 ))]}" \
    "${tiene_readme[$nombre]:-NO}"
done
# --- 6. Escribir reporte ---
REPORTE="${REPO}/semana08/inventario-report.md"
{
    echo "# Inventario del Repositorio linux-lab"
    echo ""
    echo "Generado: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo "## Total de archivos: ${#archivos[@]}"
    echo ""
    echo "## Archivos por extension"
    echo ""
    echo "| Extension | Archivos | Tamano KB |"
    echo "|-----------|----------|-----------|"
    for ext in $(printf '%s\n' "${!conteo[@]}" | sort); do
        kb=$(( ${tamano_ext["$ext"]:-0} / 1024 ))
        echo "| $ext | ${conteo[$ext]} | $kb |"
    done
    echo ""
    echo "## Resumen por semana"
    echo ""
    echo "| Semana | Scripts | Docs | Size KB | README |"
    echo "|--------|---------|------|---------|--------|"
    for ((  i=0; i<${#semanas[@]}; i++ )); do
        nombre=$(basename "${semanas[$i]}")
        echo "| $nombre | ${matriz_sem[$(( i*COLS+0 ))]} | ${matriz_sem[$(( i*COLS+1 ))]} | ${matriz_sem[$(( i*COLS+2 ))]} | ${tiene_readme[$nombre]:-NO} |"
    done
} > "$REPORTE"


echo ""
echo "Reporte guardado en: $REPORTE"
