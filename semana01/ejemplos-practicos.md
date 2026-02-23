# Pruebas que hice en la terminal

Aca anoto los comandos que fui probando para ver si de verdad funcionaban y que hacen exactamente

## Para no perderme
```bash
pwd
```
Este es basico para saber en que carpeta estoy metido ahora mismo

## Ver que hay dentro de las carpetas
```bash 
ls -l
ls -la
```
Con el -la descubri que hay muchos archivos ocultos que empiezan con un punto y que normalmente no se ven

## Moverme de un lado a otro
```bash
cd /etc
cd ~
cd -
```
El comando "cd -" te devuelve a la carpeta donde estabas justo antes, sirve para saltar rapido entre dos lugares

## Ver informacion del Sistema
```bash 
cat /proc/cpuinfo | grep "model name"
free -h
```
Con esto pude ver que procesador tengo y cuanta memoria RAM me queda libre
Lo de free -h es mejor porque te lo pone en Gigas y se entiende mas facil

## Buscar cosas
```bash
find /home/derick -name "*.md"
```
Este lo use para buscar todos los archivos de texto que terminen en .md dentro de mi carpeta personal

## Ver el historial de lo que escribi
```bash
history | tail -n 10
```
Para ver los ultimos 10 comandos que puse por si me olvido de alguno que funciono bien

**Nota: Estos comandos me sirven para moverme rapido sin usar el mouse para nada**
