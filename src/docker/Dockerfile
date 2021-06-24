FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 as nvidia
FROM ubuntu:18.04
ARG uid

ENV USER="pmr"
ENV ROS1_DISTRO="melodic"

# Preparacion del entorno
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV \
  LANG=en_US.UTF-8 \
  DEBIAN_FRONTEND=noninteractive \
  TERM=xterm

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-utils \
    bash-completion \
    build-essential \
    curl \
    git \
    libqt4-dev \
    mesa-utils \
    pkg-config \
    python-vcstools \
    python-pip \
    software-properties-common \
    ssh \
    sudo \
    tmux \
    wget

RUN apt-get update && \
    apt-get install -y dirmngr && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc

# Crear un super usuario que no requiera usar "sudo"
RUN adduser --gecos "Development User" --disabled-password -u ${uid} $USER
RUN adduser $USER sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER root

#### ROS INSTALATION PART

# Congigurar sources.list de ROS
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

# Configurar keys de ROS
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# Instalar bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall

# Instalar paquetes de ROS
RUN apt-get update && \
    apt-get install -y \
    ros-${ROS1_DISTRO}-desktop \
    && \
    apt-get clean && \
    apt-get autoremove && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc

# Inicializar rosdep
RUN rosdep init

RUN pip install --upgrade pip

# Crear el workspace
ENV WS_DIR "/pmr_ws"
RUN mkdir -p ${WS_DIR}/src/ && \
    chown -R $USER ${WS_DIR}
USER $USER
WORKDIR ${WS_DIR}

RUN rosdep update

### GAZEBO INSTALLATION PART

USER root

# Configurar sources.list de Gazebo
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -sc) main" > /etc/apt/sources.list.d/gazebo-stable.list

# Configurar keys de Gazebo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2486D2DD83DB69272AFE98867170598AF249743

# Instalar Gazebo 9
RUN apt-get update && \
    apt-get install -y \
    gazebo9 \
    libgazebo9-dev \
    ros-melodic-amcl \
    ros-melodic-diff-drive-controller \
    ros-melodic-dwa-local-planner \
    ros-melodic-ecl-threads \
    ros-melodic-gazebo-plugins \
    ros-melodic-global-planner \
    ros-melodic-joint-state-controller \
    ros-melodic-map-server \
    ros-melodic-move-base \ 
    ros-melodic-robot-localization \
    ros-melodic-slam-gmapping

## NVIDIA Docker

# Instalar OpenGL para nvidia-docker
# https://stackoverflow.com/a/53823600
COPY --from=nvidia /usr/local /usr/local
COPY --from=nvidia /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

RUN apt-get update

USER $USER

CMD ["bash"]
