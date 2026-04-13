# Semana 08: Arrays y Matrices en Bash

## Objetivo

Analizar el repositorio linux-lab usando arrays indexados, arrays asociativos y matrices simuladas para generar un inventario completo de su contenido.

## Archivos
| Archivo | Descripcion |
|---------|-------------|
| inventario.sh | Script principal de analisis |
| inventario-report.md | Reporte generado (no versionado) |
| commands-used.md | Documentacion de comandos y tecnicas |

> inventario-report.md no se versiona (.gitignore)

## Uso

### Analizar el repositorio actual
	./inventario.sh

### Analizar otro directorio
	./inventario.sh /ruta/al/repo

## Tecnicas Aplicadas

- mapfile -t para cargar find en un array
- Arrays asociativos para conteo y tamano por extension
- Matriz 1D simulando tabla 2D por semana
- column -t para salida tabular alineada
- printf para formato de columnas fijas
- Reporte en Markdown generado automaticamente

## Checklist
- [x] Carga de archivos con mapfile
- [x] Conteo por extension con array asociativo
- [x] Calculo de tamano total por extension
- [x] Deteccion de README por semana
- [x] Matriz de resumen (scripts, docs, size)
- [x] Salida formateada con column y printf
- [x] Reporte Markdown generado
- [x] Desarrollo incremental con 8+ commits
