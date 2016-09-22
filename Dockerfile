FROM ubuntu:latest
MAINTAINER Tristan Grunert <tristan.grunert@epitech.eu>

# Installation préliminaire : sudo, Makefile
RUN apt-get update -qq && \
    apt-get install -qq sudo \
    build-essential

# Installation de la lib sfml
RUN apt-get install -qq libcsfml-audio2.3 \
    libcsfml-dev \
    libcsfml-graphics2.3 \
    libcsfml-network2.3 \
    libcsfml-system2.3 \
    libcsfml-window2.3 \
    libcsfml2.3-dbg \
    libsm-dev \
    libsm6 \
    libsm6-dbg
    
# Création d'un user developer
RUN export uid=1002 gid=1002 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0666 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# Setup de l'environnement
ENV HOME /home/developer
ENV SOCKS_SERVER="socks://172.17.0.1:5080"
ENV SOCKS_VERSION=5
ENV PULSE_SERVER="unix:/tmp/pulse-unix"
ENV LD_LIBRARY_PATH="/home/developer/.froot/lib/"
ENV C_INCLUDE_PATH="/home/developer/.froot/include/"
ENV CPLUS_INCLUDE_PATH="/home/developer/.froot/include/"
ENV LIBGL_ALWAYS_SOFTWARE=true

# Installation de la Liblapin
COPY liblapin /home/liblapin/
WORKDIR /home/liblapin/
RUN /home/liblapin/install.sh

# Installation du driver graphique
COPY NVIDIA-Linux-x86_64-340.96.run /tmp/
RUN sudo apt-get install -qq kmod mesa-utils && \
    /tmp/NVIDIA-Linux-x86_64-340.96.run -a -N --ui=none --no-kernel-module

USER developer