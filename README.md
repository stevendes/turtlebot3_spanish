# Turtlebot3 con Gazebo/ROS Melodic

Este repositorio contiene todo lo necesario para correr una simulacion basica utilizando paquetes the [Turtlebot3](https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/).

Esta preparado para funcionar con el nvidia-docker, de manera que una GPU Nvidia es necesaria para asegurar el funcionamiento.

## Installacion

### Paso 0

Este paso es probablemente necesario si es la primera vez que utilizas los docker the Nvidia. Una vez instaladas las herramientas, no sera necesario hacerlo de vuelta.

[Instalar Nvidia Toolkit](https://www.pugetsystems.com/labs/hpc/Workstation-Setup-for-Docker-with-the-New-NVIDIA-Container-Toolkit-nvidia-docker2-is-deprecated-1568/)

Recomiendo revisar los comandos necesarios en la web de manera a aclarar las dudas, la siguiente es una version acortada del proceso, ante cualquier duda consultar la fuente original citada arriba.

#### Preparacion y clean-up

1. Borrar versiones viejas de docker si se tienen
```
sudo apt-get remove docker docker-engine docker.io containerd runc
```

2. Si es necesario, instalar los drivers de Nvidia (saltar este paso si tienes drivers Nvidia recientes instalados)

```
sudo add-apt-repository ppa:graphics-drivers/ppa

sudo apt-get update

sudo apt-get install build-essential dkms

sudo apt-get install nvidia-driver-435 
```
(La version instalada en este caso es la "435". Podes revisar cual es la ultima version yendo al sitio web del ppa or apretando [Tab] dos veces para expandir las opciones posibles.)

```
sudo apt-get install nvidia-driver- [Tab][Tab]
```

3. Eliminar nvidia-docker2 en caso de tenerlo instalado

```
sudo apt-get purge nvidia-docker2
```
#### Instalar docker-ce

1. Instalar paquetes requeridos
```
sudo apt-get install 
    apt-transport-https 
    ca-certificates 
    curl 
    gnupg-agent 
    software-properties-common
```

2. Agregar y chequear la docker key
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88
```
La fingerprint deberia de ser igual a "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"

3. Agregar el repo
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

4. Instalar docker-ce
```
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

5. Chequear que funcione
```
sudo docker run --rm hello-world
```

#### Instalar Container Toolkit

Ir a https://github.com/NVIDIA/nvidia-docker y comprobar cual es la ultima version de Ubuntu version soportada

1. Configurar el repo e instalar

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list


sudo apt-get update

sudo apt-get install nvidia-container-toolkit


sudo systemctl restart docker
```

2. Comprobar la instalacion (corriendo con 'sudo' por ahora)

```
sudo docker run --gpus all --rm nvidia/cuda nvidia-smi
```

3. Agregar docker al usergroup para no volver a usar sudo

```
sudo usermod -aG docker your-user-name
```
Reemplazar "your-user-name" con el nombre de usuario de tu configuracion local


### Paso 1

1. Ejecutar el script `build.sh` que construira la imagen de docker

```
./PMR/docker/build.sh
```

2. Ejecutar el script `run.sh` que te ejecutara el `docker run` con los respectivos comandos

```
./PRM/docker/run.sh
```

3. En esta pantalla ya deberias de tener acceso a ROS y Gazebo, el siguiente paso seria compilar el workspace por primera vez
```
source /opt/ros/melodic/setup.bash
catkin_make
```

4. Con esto, seran compilados los paquetes the `Turtlebot3` presentes en el repo, luego de la combinacion, se puede hacer source del nuevo workspace y probar si todo fue instalado correctamente
```
source devel/setup.bash
TURTLEBOT3_MODEL=burger roslaunch turtlebot3_gazebo turtlebot3_house.launch 
```

Si es la primera vez que lo cargan, tardara un poco ya que tiene que descargar los modelos del world, pueden probar con `turtlebot3_empty_world.launch` para comprobar que todo este bien sin tener que descargar los modelos.
