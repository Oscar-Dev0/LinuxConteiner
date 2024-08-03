# Usa la última versión de Ubuntu
FROM ubuntu:latest

# Actualiza los repositorios y instala OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server

# Crea el directorio para el demonio de SSH
RUN mkdir /var/run/sshd

# Configura una contraseña para el usuario root
RUN echo 'root:password' | chpasswd

# Permite la autenticación por root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Permite el acceso por contraseña
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expon el puerto 22 para SSH
EXPOSE 22

# Ejecuta el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
