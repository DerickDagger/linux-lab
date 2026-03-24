# Semana 01: Fundamentos de Linux + Git Setup

## Objetivos
- Comprender estructura del filesystem
- Navegar el sistema con confianza
- Configurar Git correctamente

## Contenido

```
semana01/
├── README.md
├── filesystem-map.md
├── filesystem-diagram.txt
└── ejemplos-practicos.md
```
- `filesystem-map.md` - Documentación personal del uso de directorios
- `filesystem-diagram.txt` - Un diagrama visual simple de la estructura de carpetas
- `ejemplos-practicos.md` - Comandos que probé y que me parecieron útiles

## Comandos Aprendidos

### Navegación
- `pwd` Para saber donde me encuentro
- `ls -la` Para ver todo, incluso archivos ocultos
- `cd` Para cambiar directorio
- `cd ..` Para subir de nivel
- `tree` - Visualizar estructura

### Ayuda
- `man` - Manual pages
- `--help` - Ayuda rápida

### Git Básico
- `git init` - Inicializar repositorio
- `git add` - Agregar al staging area
- `git commit` - Guardar cambios
- `git status` - Ver estado
- `git log` - Ver historial

## Checklist
  - [x] Repositorio Git inicializado
  - [x] `filesystem-map.md` completo (10+ directorios)
  - [x] `filesystem-diagram.txt` creado
  - [x] `ejemplos-practicos.md` con comandos
  - [x] Mínimo 5 commits descriptivos
  - [x] Repositorio en GitHub

## Ejecución

```bash
# Navegar por el sistema
cd /
ls -la
pwd

# Explorar con tree
tree -L 1 /

# Probar ejemplos
ls -l
cd /etc
cd ~
cd -
cat /proc/cpuinfo | grep "model name"
free -h
find /home/derick -name "*.md"
history | tail -n 10
```

## Recursos

- Man pages: `man ls`, `man bash`
- FHS (Filesystem Hierarchy Standard)
- GitHub: https://github.com/DerickDagger/linux-lab
