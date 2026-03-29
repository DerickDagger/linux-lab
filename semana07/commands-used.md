# Comandos de la Semana 07

## Generación de secuencias y control de tiempo
- **seq**: 	Genera secuencias numéricas (rangos). Útil para iteraciones con un número fijo de pasos.
- **sleep**: 	Pausa la ejecución del script durante un número determinado de segundos.
- **timeout**: 	Ejecuta un comando con un límite de tiempo. Si el comando no termina, lo finaliza automáticamente.

## Estructuras de repetición (Ciclos)
- **for**: 	Itera sobre una lista de elementos, como archivos en un directorio o una secuencia de números.
- **while**: 	Repite un bloque de código mientras la condición evaluada sea verdadera.
- **until**: 	Repite un bloque de código hasta que la condición evaluada sea verdadera (opuesto a while).
- **break**: 	Termina la ejecución del bucle actual de forma inmediata.
- **continue**: Salta el resto del código en la iteración actual y pasa a la siguiente.

## Manejo de entrada y señales
- **xargs**: 	Toma la salida de un comando y la convierte en argumentos para otro comando.
- **trap**: 	Permite capturar señales del sistema (como SIGINT al presionar Ctrl+C) para ejecutar acciones antes de salir.
- **tee -a**: 	Lee la entrada estándar y la escribe simultáneamente en la pantalla y en un archivo (modo append).
- **while IFS= read -r**: Estructura utilizada para leer archivos o flujos de texto línea por línea de forma segura.

## Variables y Operaciones
- **$(( ))**: 	Sintaxis para realizar expansiones y operaciones aritméticas dentro de Bash.
- **shift**: 	Desplaza los parámetros posicionales ($1, $2, etc.) hacia la izquierda, útil para procesar argumentos en un ciclo.
