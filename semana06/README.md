# Semana 06: Bash Scripting - Condicionales

## Descripcion

'backup-check.sh' valida el estado de un directorio de backups.
Verifica existencia, contenido, antiguedad y tamaño, y emite un diagnostico con niveles OK / WARNING / ERROR.

## Uso
```bash
./backup-check.sh			# Usa /backup por defecto
./backup-check.sh /mnt/respaldo		# Directorio personalizado
./backup-check.sh ~/backup-prueba 	# Directorio de prueba
./backup-check.sh --version 		# Version del script
./backup-check.sh --help    		# Ayuda
```

## Estructura
```
semana06/
├── backup-check.sh      		# Script principal (ejecutable)
├── commands-used.md     		# Guia de comandos aprendidos
├── README.md            		# Documentacion del laboratorio
└── logs/                		# Carpeta de registros (auto-generada)
    └── backup-check-YYYYMMDD.log
```

## Verificaciones que realiza
1. Existencia y permisos del directorio de backups.
2. Presencia de archivos .tar.gz y que no esten vacios.
3. Antiguedad: alerta si el ultimo backup supera las 24 horas.
4. Tamaño: alerta si el directorio esta fuera del rango esperado.

## Salida de ejemplo

```
[2026-03-21 23:13:10] [INFO   ] === backup-check.sh v1.0.0 - Inicio ===
[2026-03-21 23:13:10] [INFO   ] Directorio objetivo: /home/derick/backup-prueba
[2026-03-21 23:13:10] [INFO   ] Verificando directorio: /home/derick/backup-prueba
[2026-03-21 23:13:10] [OK     ] Directorio accesible: /home/derick/backup-prueba
[2026-03-21 23:13:10] [INFO   ] Buscando archivos de backup (*.tar.gz)...
[2026-03-21 23:13:10] [OK     ] Se encontraron 1 archivo(s) de backup.
[2026-03-21 23:13:10] [OK     ] Ultimo backup: backup_2026-03-21.tar.gz
[2026-03-21 23:13:10] [INFO   ] Verificando antiguedad...
[2026-03-21 23:13:10] [OK     ] 1 backup(s) recientes (ultimas 24 h).
[2026-03-21 23:13:10] [INFO   ] Verificando tamanio...
[2026-03-21 23:13:10] [OK     ] Tamanio dentro del rango: 15 MB
[2026-03-21 23:13:10] [INFO   ] === Verificacion completada ===
[2026-03-21 23:13:10] [OK     ] RESULTADO: todos los checks pasaron.

```
## Conceptos aprendidos
- El comando test y la sintaxis [ ] y [[ ]]
- if / elif / else con operadores numericos, de cadena y de archivo
- Operadores logicos &&, || y !
- La estructura case / esac
- Funciones con parametros, return y local
- Logging estructurado con tee -a
- Medicion de espacio con du -sm
- Busqueda por antiguedad con find -mtime
