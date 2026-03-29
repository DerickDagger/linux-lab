# Semana 07: Monitor de Recursos del Sistema

## Descripción
Script de monitoreo continuo con ciclo `while`.
Comprueba disco, RAM y CPU, registra en log y emite alertas por umbrales configurables.

## Uso
- `./monitor.sh` 				# Monitoreo continuo
- `./monitor.sh --max 10`			# 10 comprobaciones
- `./monitor.sh --intervalo 5`		# Cada 5 segundos
- `./monitor.sh --umbral-disco 70` 	# Alerta al 70%

Detener con `Ctrl + C` (muestra resumen antes de salir).

## Archivos
- **monitor.sh:** 	Script principal
- **monitor.log:** 	Generado al ejecutar (en .gitignore)
- **commands-used.md:** Comandos nuevos de la semana
