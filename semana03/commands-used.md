# Comandos Utilizados - Semana 3

## Procesamiento de Texto

### grep
```bash
grep -c "| ERROR |" sistema.log	   # Contar coincidencias
grep -E "\| (ERROR|FATAL) \|" log  # Expresion extendida
```
**Para que sirve:** Filtrar lineas por patron.

### cut
```bash
cut -d '|' -f2 sample.log	 # Campo 2 con separador
    |
cut -d '|' -f4 sample.log	 # Campo 4 (mensaje)
```
**Para que sirve:** Extraer columnas de texto estructurado.

### sort
```bash
sort archivo.txt		 # Orden alfabetico
sort -rn archivo.txt 		 # Reverso numerico
sort -k2 tabla.txt		 # Por columna 2
```
**Para que sirve:** Ordenar lineas (necesario antes de uniq).

### uniq
```bash
sort file | uniq -c 		# Contar frecuencias
sort file | uniq -d	 	# Solo duplicados
```
**Para que sirve:** Eliminar o contar lineas duplicadas.

### wc
```bash
wc -l archivo.txt		 # Contar lineas
grep "ERROR" log | wc -l	 # Contar errores
```
**Para que sirve:** Contar lineas, palabras o bytes.

### tr
```bash
tr -d ' '			 # Eliminar espacios
tr 'a -z' 'A -Z'		 # Cambiar a mayusculas
```
**Para que sirve:** Transformar o eliminar caracteres.

### awk
```bash
awk '{print $2}' archivo	 # Imprimir col 2
awk '{sum += $1} END{print sum}' # Sumar columna
awk -F '|' '{print $2}'		 # Separador |
```
**Para que sirve:** Procesar y calcular sobre columnas.

## Redireccion y Pipes

```bash
comando > archivo.txt		 # Guardar salida
comando >> archivo.txt		 # Agregar a archivo
comando 2>/dev/null		 # Suprimir errores
cmd1 | cmd2 | cmd3		 # Encadenar comandos
```

## Pipeline Completo del Analizador

```bash
cut -d '|' -f2 sample.log | \
    tr -d ' ' | \
    sort | \
    uniq -c | \
    sort -rn | \
    head -10
```
** Lectura :** Extrae IPs	 quita espacios		 ordena
cuenta frecuencias	 ordena por frecuencia		 top 10.
