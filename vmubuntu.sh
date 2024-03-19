#!/bin/bash
# Programa para levantar maquina virtual de ubuntu server
# Autor: Gabriel

# Actualizar lista de paquetes
sudo apt update && sudo apt upgrade -y

# Configuracion zona horario en Argentina
timedatectl set-timezone America/Argentina/Buenos_Aires

# Configurar nombre de host
sudo hostname bootcampwebexperto

# Crear usuario sudo
sudo adduser webexpertosudo
sudo usermod -aG sudo webexpertosudo

# Crear usuario para conexion ssh
sudo adduser ssh
sudo usermod -aG ssh

# Validar docker e instalar

docker --version
if [[ $(apt-mark showinstall | grep -q "^docker") == "^docker" ]]; then
      echo "Instalando Docker"
      sudo apt-get update
      apt-mark showinstall | grep -q "^docker"
      sudo apt-get install ca-certificates curl -y
      sudo install -m 0755 -d /etc/apt/keyrings -y
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
      sudo chmod a+r /etc/apt/keyrings/docker.asc

      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update

      sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
      docker --version
else
      echo "Docker ya esta instalado"
fi

# Validar docker compose e instalar
docker compose version
if [[ $(apt-mark showinstall | grep -q "^docker-compose-plugin") == "docker-compose-plugin" ]]; then
      echo "Instalando Docker Compose"       
      sudo apt-get update
      sudo apt-get install docker-compose-plugin -y
      docker compose version
else
      echo "Docker Compose ya esta instalado"
fi

# Crear el grupo docker e iniciar el servicio
sudo groupadd docker
sudo usermod -aG docker webexpertosudo
su - webexpertosudo
sudo systemctl status docker
sudo systemctl enable docker
sudo systemctl start docker

# Instalar mc
sudo apt install mc -y

# Instalar vim
sudo apt install vim -y

# Instalar net-tools
sudo apt install net-tools -y

# Crear usuario nginx con permisos docker
sudo adduser nginx
sudo usermod -aG docker nginx
su - nginx
sudo systemctl status docker
sudo systemctl enable docker
sudo systemctl start docker

# Instalar git
sudo apt install git -y
git config --global user.name "giurushima"
git config --global user.email "giurushima@hotmail.com"

# 4: Clonar repositorio con user nginx
git clone https://github.com/pablokbs/peladonerd.git

# 5: Crear archivo de nginx con repo app
git clone https://github.com/giurushima/calculadora-epeV3.git
