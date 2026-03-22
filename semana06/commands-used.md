# Comandos Usados - Semana 6

## Condicionales
- **`[ -d dir ]`**: 		Verifica que existe y es un directorio.
- **`[ -f archivo ]`**: 	Verifica que existe y es un archivo regular.
- **`[ -r ruta ]`**: 		Verifica que tienes permiso de lectura.
- **`[ -s archivo ]`**: 	Verifica que el archivo NO esta vacio (tiene tamaño > 0).
- **`[ -e ruta ]`**: 		Verifica que la ruta existe (sea archivo, carpeta, etc.).
- **`[ -z "$var" ]`**: 		Verifica que la cadena de texto esta vacia.
- **`[ -n "$var" ]`**: 		Verifica que la cadena de texto NO esta vacia.
- **`[ $a -eq $b ]`**: 		Compara numeros: **Igual** (Equal).
- **`[ $a -lt $b ]`**: 		Compara numeros: **Menor que** (Less Than).
- **`[ $a -gt $b ]`**: 		Compara numeros: **Mayor que** (Greater Than).

## Estructura de Control
- **`if / elif / else / fi`**:	Estructura condicional.
- **`case / esac`**: 		Comparacion contra multiples patrones.
- **`return 0|1`**: 		Codigo de salida de una funcion (0 = exito, 1 = error).
- **`local var`**: 		Define una variable que solo existe dentro de una funcion.

## Logging y Salida
- **`tee -a archivo`**: 	Muestra el resultado en pantalla y ademas lo guarda al final del archivo.
- **`printf "[%s]..."`**: 	Permite darle un formato profesional y alineado a los mensajes de log.

## Tamaño y Tiempo de Archivos
- **`du -sm dir`**: 		Tamaño del directorio en MB (solo el total).
- **`du -sh dir`**: 		Tamaño del directorio en formato legible (KB, MB, GB).
- **`find -mtime -1`**: 	Busca archivos modificados en las ultimas 24h.
- **`find -mtime +7`**: 	Busca archivos modificados hace mas de 7 dias.
- **`find -maxdepth 1`**: 	No busca dentro de subcarpetas, se queda en la actual.
- **`find ... | sort | tail -1`**: Ordena los archivos y devuelve el mas reciente.

## Combinaciones Logicas
- **`&&`**: 			**AND** (Y). Ambas condiciones deben ser verdader	as.
- **`||`**: 			**OR** (O). Al menos una condicion verdadera.
- **`!`**: 			**NOT** (NO). Niega la condicion.
