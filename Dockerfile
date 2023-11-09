FROM ubuntu:22.04

LABEL maintainer="David Lung (lungdm@gmail.com); Padraig Gleeson (p.gleeson@gmail.com)"

ARG INTEL_SDK_VERSION=2017_7.0.0.2511_x64

#COPY ./silent-intel-sdk.cfg /tmp/silent-intel-sdk.cfg


ARG USR=ow
ENV USER=$USR

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get dist-upgrade -y

RUN mkdir -p /etc/sudoers.d && \
  export uid=1000 gid=1000 && \
  mkdir -p /home/$USER && \
  echo "$USER:x:${uid}:${gid}:$USER,,,:/home/$USER:/bin/bash" >> /etc/passwd && \
  echo "$USER:x:${uid}:" >> /etc/group && \
  echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
  chmod 0440 /etc/sudoers.d/$USER && \
  chown ${uid}:${gid} -R /home/$USER


ENV DEBIAN_FRONTEND noninteractive # TODO: change

#RUN useradd -ms /bin/bash $USER


################################################################################
########     Update/install essential libraries

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
  wget nano htop build-essential make git automake autoconf \
  g++ rpm libtool libncurses5-dev zlib1g-dev bison flex lsb-core \
  sudo xorg openbox x11-xserver-utils \
  libxext-dev libncurses-dev python3-dev mercurial \
  freeglut3-dev libglu1-mesa-dev libglew-dev python3-dev python3-pip python3-lxml  python3-scipy python3-tk \
  kmod dkms linux-source linux-headers-generic \
  maven openjdk-8-jdk \
  python3-setuptools python3-yaml libnuma1 \
  openmpi-bin  libopenmpi-dev \
  libgl1-mesa-glx libgl1-mesa-dri libfreetype6-dev \
  libxft-dev python3-matplotlib unzip ffmpeg xvfb tmux

#RUN  sudo pip install --upgrade pip
#RUN sudo apt-get install nvidia-opencl-dev

RUN sudo usermod -a -G video $USER

#USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

#### TODO: check that this is the best way to switch to py3...
RUN  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN  sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10


################################################################################
########     Install NEURON simulator

RUN pip3 install neuron==8.0.1


################################################################################
########     Install c302 for building neuronal network models

RUN git clone https://github.com/openworm/c302.git && \
  cd c302 && \
  git checkout ow-0.9.3a && \
  sudo pip install .

# Note: pyNeuroML installed with the above library

RUN pip3 install owmeta-core==0.13.5
RUN owm bundle remote --user add ow 'https://raw.githubusercontent.com/openworm/owmeta-bundles/master/index.json'


################################################################################
########     Install Sibernetic for the worm body model

RUN git clone https://github.com/openworm/sibernetic.git && \
  cd sibernetic && \
  git checkout ow-0.9.3  # fixed to a specific branch


################################################################################
########     Set some paths//environment variables

ENV JNML_HOME=$HOME/jNeuroML
ENV PATH=$PATH:$JNML_HOME

ENV C302_HOME=$HOME/c302/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$PYTHONPATH:$HOME/c302:$SIBERNETIC_HOME


################################################################################
########     Install Intel OpenCL libraries needed for Sibernetic

RUN mkdir intel-opencl-tmp && \
  cd intel-opencl-tmp && \
  mkdir intel-opencl && \
  wget https://github.com/openworm/OpenWorm/raw/dev_inte/SRB5.0_linux64.zip && \
  unzip SRB5.0_linux64.zip && \
  tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz && \
  sudo cp -R intel-opencl/* / && \
  sudo ldconfig && \
  cd .. && \
  sudo rm -r intel-opencl-tmp

RUN sudo cp -R /opt/intel/opencl/include/CL /usr/include/ && \
sudo apt install -y ocl-icd-opencl-dev vim
#sudo ln -s /opt/intel/opencl/libOpenCL.so.1 /usr/lib/libOpenCL.so


################################################################################
########     Build Sibernetic

RUN cd sibernetic && \
    sed -i -e "s/n2.7/n3.10/g" makefile && \
    make clean && make all && ldd ./Release/Sibernetic  # Use python 3 libs


################################################################################
########     Copy master python script

# Not working with --chown=$USER:$USER
COPY ./master_openworm.py $HOME/master_openworm.py
RUN sudo chown $USER:$USER $HOME/master_openworm.py

RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc

RUN pip list

RUN echo "Built the OpenWorm Docker image!"
