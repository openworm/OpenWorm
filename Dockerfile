FROM ubuntu:24.04

LABEL maintainer="David Lung (lungdm@gmail.com); Padraig Gleeson (p.gleeson@gmail.com)"

ARG USR=ow
ENV USER=$USR

RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get dist-upgrade -y

RUN apt-get update && apt-get install -y sudo && \
    useradd -m -s /bin/bash -u 1000 $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

ENV DEBIAN_FRONTEND=noninteractive


################################################################################
########     Update/install essential libraries

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils \
  wget nano htop build-essential make git automake autoconf \
  g++ rpm libtool libncurses5-dev zlib1g-dev bison flex \
  sudo xorg openbox x11-xserver-utils \
  libxext-dev libncurses-dev \
  freeglut3-dev libglu1-mesa-dev libglew-dev python3-dev python3-pip \
  kmod dkms linux-source linux-headers-generic \
  openjdk-21-jdk \
  libnuma1 \
  libgl1 libglx-mesa0  libgl1-mesa-dri libfreetype6-dev \
  libxft-dev  unzip ffmpeg xvfb tmux

#RUN  sudo pip install --upgrade pip

RUN sudo usermod -a -G video $USER

#USER $USER
ENV HOME=/home/$USER
WORKDIR $HOME



################################################################################
########     Install NEURON simulator

RUN sudo pip install neuron==8.2.6  --break-system-packages


################################################################################
########     Install c302 for building neuronal network models

RUN git clone https://github.com/openworm/c302.git && \
  cd c302 && \
  git checkout ow-0.9.9 && \
  sudo pip install .  --break-system-packages

# Note: pyNeuroML installed with the above library



################################################################################
########     Install Sibernetic for the worm body model

RUN git clone https://github.com/Ahiknsr/sibernetic.git && \
  cd sibernetic && \
  git checkout ow-0.9.10  # fixed to a specific branch


################################################################################
########     Install extra Python dependencies

RUN sudo pip install ruff  --break-system-packages


################################################################################
########     Set some paths//environment variables

ENV C302_HOME=$HOME/c302/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$HOME/c302:$SIBERNETIC_HOME

ENV NEURON_MODULE_OPTIONS=-nogui


################################################################################
########     Install AMD's OpenCL Drivers (Todo: Add Nvidia driver support)
RUN apt-get update && \
    apt-get install -y \
    ocl-icd-libopencl1 \
    ocl-icd-opencl-dev \
    opencl-clhpp-headers \
    pocl-opencl-icd \
    mesa-opencl-icd \
    clang-16 \
    lld-16 \
    clinfo

RUN echo "OpenCL Driver Installation Complete"

RUN echo "CLINFO:"
RUN clinfo


################################################################################
########     Build Sibernetic
RUN cd sibernetic && \
    make clean && make all && ldd ./Release/Sibernetic

################################################################################
########     Set up JupyterLab

#RUN sudo pip install notebook jupyterlab --break-system-packages


################################################################################
########     Copy master python script

# Not working with --chown=$USER:$USER
COPY ./master_openworm.py $HOME/master_openworm.py
RUN sudo chown $USER:$USER -R $HOME

RUN printf '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alth"\n' >> ~/.bashrc



RUN pip list

RUN echo "Built the OpenWorm Docker image!"

