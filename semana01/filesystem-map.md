# Lo que entendi del arbol de directorios

Estuve curioseando un poco la terminal y esto es lo que pude sacar de como se organiza Linux
No hay un Disco C: como en Windows, todo empieza desde un solo lugar llamado raiz

## La raiz /
Es el origen de todo. Si pongo cd / me lleva al puro inicio del arbol. Actua como la carpeta madre

## Mi carpeta personal /home/derick
Aqui es donde se pasa la mayor parte del tiempo
Es un espacio para guardar tareas/trabajos, mis descargas y mis cosa
Lo bueno es que no se necesita pedir permisos de administrador para crear una carpeta

## Configuraciones en /etc
Aqui estan todos los archivos que dicen como deben funcionar los programas
Revisandolo vi archivos como "hosts",
Se recomienda no borrar nada de aqui porque facilmente el sistema podria mostrar errores

## Cosas que cambian /var
Se llama asi por "variable"
Aqui el sistema guarda los logs o registros de lo que va pasando
Si algo falla, probablemente en /var/log sale el porque

## Comandos y programas /bin y /usr/bin
Basicamente aqui viven los comandos como ls, cp o mkdir
Son los programas que mas se utilizan

## Basurero temporal /tmp
Es una carpeta para guardar cosas que no importan mucho
Lo que se queda aqui se borra cuando el ordenador se reinicia

## El hardware como archivos /dev
Esto me parecio raro, en Linux hasta los discos duros son archivos
Mi disco principal sale como sda
Tambien hay un archivo llamado null que es como un agujero negro donde puedes tirar texto y desaparece

## El arranque /boot
Esta carpeta almacena archivos escenciales para el inicio del Sistema Operativo
Sin estos archivos el ordenador no puede cargar el sistema

## Info del sistema /proc
No es una carpeta real en el disco, es mas como una ventana a la memoria
Con el comando cat /proc/cpuinfo sale toda la informacion del procesador

## Programas extra /opt
Es para instalar cosas de terceros que no vienen por defecto (google chrome, spotify, etc)

**Nota: Al principio me perdi un poco pero ya le voy captando el hilo
lo mas importante es saber que mis cosas estan en /home y las configuraciones en /etc**
