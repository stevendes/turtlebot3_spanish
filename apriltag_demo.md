# Apriltag demo

Para ejecutar el demo y ver como funcionan los apriltags, hay que seguir pasos diferentes a los mencionados en el Readme.me

## Instrucciones

0. Seguir el [PASO 0](https://github.com/stevendes/turtlebot3_spanish/blob/master/README.md#paso-0) para instalar el entorno 


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
rosdep install --from-paths src --ignore-src -r -y
catkin_make_isolated
source devel/setup.bash
```

4. Lanzar la simulacion
```
TURTLEBOT3_MODEL=waffle_pi roslaunch apriltag_simulation apriltag_simulation.launch
```

5. Abriendo otra terminal y entrando al docker, pueden abrir el teleop y mover el Turtlebot3 por el mapa, en Rviz seran capaces de visualizar la deteccion de los tags.

```
source devel/setup.bash
TURTLEBOT3_MODEL=waffle_pi roslaunch turtlebot3_teleop turtlebot3_teleop_key.launch
```
