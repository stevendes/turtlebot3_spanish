#!/bin/bash

CONTAINER=pmr_ros

WS_PATH=$( cd ../.. && pwd )
echo "Cargando la imagen $CONTAINER..."

# Crear las carpetas de build y devel (esto evitara compilar cada vez que abras el docker)
cd ../.. && mkdir -p build devel

xhost +local:docker
docker run  --rm --gpus all --net=host --security-opt apparmor=unconfined -it \
-e DISPLAY=${DISPLAY} \
-e XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
-e QT_X11_NO_MITSHM=1 \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ${WS_PATH}/src:/pmr_ws/src:rw \
-v ${WS_PATH}/build:/pmr_ws/build:rw \
-v ${WS_PATH}/devel:/pmr_ws/devel:rw \
${CONTAINER} 
