Evaluacion practica Levi Hazael Ramos Reyes

El apartado de sqlserver la parte 1: modelado y procedimiento almacenado en sql server. se encuentra dentro de la carpeta sql, ahi se encuentra todo el script

antes de poner a funcionar el proyecto en la consola de comandos dentro del proyecto, coloque el comando npm install, para que se le instalen todos los paquetes que se han usado

configure el archivo .env con sus credenciales de sqlserver (yo hice un cambio para que me lograra funcionar, es que en la parte de SESSION_DRIVER=database yo lo cambie por file ya que no me agarraba las credenciales
ni del usuario ni el puerto ni el host. al parecer habia un error en el inicio de sesion). 

luego ejecutar en una consola npm run dev y en otra consola ejecute el comando php artisan serve. el enlace que este ultimo haya generado es donde debe entrar, generalmente es algo parecido a http://127.0.0.1:8000. apriete la tecla ctrl y presione el clic izquierdo del mouse sobre el enlace y con esto ya estaria funcionando el sistema

el proyecto se realizo usando bootstrap
