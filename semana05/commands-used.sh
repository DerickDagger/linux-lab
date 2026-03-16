# Comandos usados - Semana 5

## Informacion del sistema
- `uname -s`            Nombre del kernel
- `uname -r`            Version del kernel
- `uname -m`            Arquitectura del procesador
- `hostname`            Nombre del equipo
- `uptime -p`           Tiempo encendido en formato legible
- `date`                Fecha y hora del sistema

## CPU y memoria

- `nproc`               Numero de nucleos disponibles
- `free -h`             Uso de RAM en formato humano
- `uptime | awk`        Extraer carga de CPU del uptime

## Disco

- `df -h`               Uso de disco en formato legible
- `df -h | grep -v`     Excluir sistemas virtuales (tmpfs, udev)

## Procesos

- `ps aux`              Todos los procesos (formato BSD)
- `ps aux --sort=-%cpu` Ordenar por CPU descendente
- `ps -u $USER`         Procesos del usuario actual
- `ps --no-headers`     Omitir encabezado (util con wc -l)

## Variables usadas

- `$USER`               Usuario actual del sistema
- `$#`                  Numero de argumentos del script
- `$1`                  Primer argumento
- `$(comando)`          Sustitucion de comandos
- `${var:-default}`     Valor por defecto si var esta vacia
