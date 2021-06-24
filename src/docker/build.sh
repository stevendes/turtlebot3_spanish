#!/bin/bash

# Guardar el numero de UID
USER_ID=$(id -u)

echo "Creando la imagen de Docker..."
# Construir la imagen de Docker ROS
docker build . --build-arg uid="${USER_ID}" -t pmr_ros
