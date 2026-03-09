# Semana 04: Editores y Dotfiles

## Objetivo
Crear un entorno de trabajo personalizado y reproducible mediante dotfiles versionados en Git e instalables con un solo script.

## Archivos del Proyecto
| Archivo | Descripcion |
| ------- | ----------- |
| `install.sh` | Instala dotfiles en ~/ con symlinks |
| `uninstall.sh` | Elimina los symlinks creados |
| `dotfiles/bashrc` | Configuracion de Bash, historial, PS1 |
| `dotfiles/bash_aliases` | Aliases y funciones de utilidad |
| `dotfiles/vimrc` | Configuracion de vim |

## Instalacion

```bash
cd ~/linux-lab/semana04
chmod +x install.sh
./install.sh
source ~/.bashrc
```
## Desinstalacion

```bash
./uninstall.sh
```
## Aliases incluidos

| Alias | Comando real | Para que sirve |
|-------|--------------|----------------|
| `ll` | `ls -lhF --color=auto` | Listar con detalles |
| `la` | `ls -lhaF --color=auto` | Listar con ocultos |
| `..` | `cd ..` | Subir un directorio |
| `c`  | `clear` | Limpiar pantalla |
| `gs` | `git status` | Estado de Git |
| `ga` | `git add` | Agregar a staging |
| `gc` | `git commit` | Commit |
| `gp` | `git push` | Push a remoto |
| `gl` | `git log --oneline --graph --all` | Historial visual |


## Funciones incluidas
| Funcion | Uso | Descripcion |
|---------|-----|-------------|
| `mkcd` | `mkcd mi - carpeta` | Crear directorio y entrar |
| `extraer` | `extraer archivo.tar.gz` | Descomprimir cualquier formato |
| `buscar` | `buscar "patron"` | grep recursivo con color |
| `duh` | `duh` | Uso de disco ordenado (top 10) |
| `bak` | `bak archivo.txt` | Backup con fecha |

## Comandos Aprendidos

- `vim` - Editor modal de texto
- `nano` - Editor de texto sencillo
- `alias` - Crear atajos de comandos
- `source ~/.bashrc` - Recargar configuracion
- `ln -s` - Crear enlace simbolico
- `export VARIABLE=valor` - Variable de entorno
- `type comando` - Ver de donde viene un comando
- `which comando` - Ruta del ejecutable

## Checklist
- [x] dotfiles/bashrc con PS1 personalizado
- [x] dotfiles/bash_aliases con aliases y funciones
- [x] dotfiles/vimrc con configuracion basica
- [x] install.sh funcional con backup automatico
- [x] uninstall.sh funcional
- [x] Instalacion verificada: symlinks activos
- [x] Aliases probados en terminal
- [x] Desarrollo incremental con 7+ commits
