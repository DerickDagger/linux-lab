# Semana 09: Gestion de Procesos

## Descripción
`monitor-procesos.sh` Herramienta CLI para inspeccionar procesos del sistema, detectar anomalías y generar reportes con timestamp.

## Uso
./monitor-procesos.sh [opciones] [proceso1 proceso2 ...]

Opciones:
  - u USUARIO    Inspeccionar árbol de un usuario especifico
  - t UMBRAL     % CPU para clasificar como "alto consumo" (default: 50)
  - k            Enviar SIGTERM a procesos sobre el umbral
  - r ARCHIVO    Guardar reporte en ruta específica
  - h            Mostrar ayuda

## Ejemplos
```
./monitor-procesos.sh                     # Reporte completo
./monitor-procesos.sh bash sshd nginx     # Verificar procesos
./monitor-procesos.sh -u root -t 30       # Alto consumo para root
./monitor-procesos.sh -t 70 -k            # Terminar procesos pesados
```
## Estructura
```
semana09/
  	monitor-procesos.sh    # Script principal
  	lib/
  		procesos.sh       # Funciones de inspeccion
   		alertas.sh        # Logging con colores
 	reportes/              # Reportes generados (no versionados)
```
## Comandos aprendidos
- ps aux / ps -ef / ps -eo
- pgrep / pkill / pidof
- kill -15 / kill -9 / kill -HUP
- jobs / fg / bg
- nohup / disown
- nice / renice
- pstree
