# Semana 05: Bash Scripting - Fundamentos

## Descripcion

`sysinfo.sh` genera un reporte del estado del sistema. Muestra informacion de CPU, RAM, disco y procesos activos.

## Uso

```bash
./sysinfo.sh           # Reporte completo
./sysinfo.sh --cpu     # Solo CPU
./sysinfo.sh --mem     # Solo memoria
./sysinfo.sh --disk    # Solo disco
./sysinfo.sh --proc    # Solo procesos
./sysinfo.sh --version # Version del script
./sysinfo.sh --help    # Ayuda
```
## Estructura

```
semana05/
├── README.md
├── sysinfo.sh
└── commands-used.md
```

## Conceptos aprendidos

- Variables en Bash (declaracion, expansion, valores por defecto)
- Parametros posicionales ($1, $@, $#)
- Variables especiales ($?, $$, $USER)
- Aritmetica con $(())
- Sustitucion de comandos con $()
- echo y printf para formato de salida
- read para entrada del usuario
- Comandos de sistema: uname, hostname, uptime, date, nproc, free, df, ps
- Validacion de argumentos y exit con codigos

## Ejecucion

```bash
cd ~/linux-lab/semana05
chmod +x sysinfo.sh
./sysinfo.sh
```
