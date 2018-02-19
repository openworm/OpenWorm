FROM ubuntu:16.04

MAINTAINER David Lung "lungdm@gmail.com"


ARG INTEL_SDK_VERSION=2017_7.0.0.2511_x64

COPY ./silent-intel-sdk.cfg /tmp/silent-intel-sdk.cfg


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


RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
  wget \
  nano \
  htop \
  build-essential \
  make \
  git \
  automake \
  autoconf \
  g++ \
  rpm \
  libtool \
  libncurses5-dev \
  zlib1g-dev \
  bison \
  flex \
  lsb-core \
  sudo \
  xorg \
  openbox \
  x11-xserver-utils \
  libxext-dev libncurses-dev python-dev mercurial \
  freeglut3-dev libglu1-mesa-dev libglew-dev python-dev python-pip python-lxml python-numpy python-scipy python-tk \
  kmod dkms \
  linux-source linux-headers-generic \
  maven openjdk-8-jdk \
  python-setuptools python-yaml libnuma1 \
  openmpi-bin  libopenmpi-dev \
  libgl1-mesa-glx libgl1-mesa-dri libfreetype6-dev \ 
  libpng12-dev libxft-dev python-matplotlib xubuntu-desktop ffmpeg xvfb tmux

#RUN  sudo pip install --upgrade matplotlib 

#RUN sudo apt-get install nvidia-opencl-dev

RUN sudo usermod -a -G video $USER

USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

RUN mkdir neuron && \
  cd neuron && \
  git clone https://github.com/nrnhines/iv.git && \
  git clone https://github.com/nrnhines/nrn.git && \
  cd iv && \
  git checkout 76c123b && \
  ./build.sh && \
  ./configure --prefix=`pwd` && \
  make && \
  sudo make install && \
  cd ../nrn && \
  git checkout e0950a1 && \
  ./build.sh && \
  ./configure --prefix=`pwd` --with-iv=$HOME/neuron/iv --with-nrnpython=/usr/bin/python --with-paranrn && \
  make && \
  sudo make install && \
  cd src/nrnpython && \
  sudo python setup.py install

RUN mkdir intel-opencl-tmp && \
  cd intel-opencl-tmp && \
  mkdir intel-opencl && \
  wget http://registrationcenter-download.intel.com/akdlm/irc_nas/11396/SRB5.0_linux64.zip && \
  unzip SRB5.0_linux64.zip && \
  tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz && \
  sudo cp -R intel-opencl/* / && \
  sudo ldconfig && \
  cd .. && \
  sudo rm -r intel-opencl-tmp

RUN wget http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/11705/intel_sdk_for_opencl_$INTEL_SDK_VERSION.tgz && \
  tar xvf intel_sdk_for_opencl_$INTEL_SDK_VERSION.tgz && \
  cd intel_sdk_for_opencl_$INTEL_SDK_VERSION && \
  sudo ./install.sh --silent /tmp/silent-intel-sdk.cfg && \
  cd $HOME && \
  rm intel_sdk_for_opencl_$INTEL_SDK_VERSION.tgz && \
  sudo rm /tmp/silent-intel-sdk.cfg
  
RUN git clone https://github.com/NeuroML/pyNeuroML.git && \
  cd pyNeuroML && \
  git checkout ow-0.8a  && \
  sudo python setup.py install

RUN git clone https://github.com/openworm/PyOpenWorm.git && \
  cd PyOpenWorm && \
  git checkout 7ff1266 && \
  sudo python setup.py install

RUN git clone https://github.com/openworm/CElegansNeuroML.git && \  
  cd CElegansNeuroML && \
  # Pointing this at a recent commit that adds python 3 support!
  # https://github.com/openworm/CElegansNeuroML/commit/c8b13642d79335bb8157431b83624e33d50a166e
  git checkout c8b1364

RUN git clone https://github.com/openworm/sibernetic.git && \
  cd sibernetic && \
  # fixed to a specific commit in development branch:
  # https://github.com/openworm/sibernetic/commit/3eb9914db040fff852cba76ef8f4f39d0bed3294
  git checkout 3eb9914 && \
  make clean && make all

ENV JNML_HOME=$HOME/jNeuroML
ENV PATH=$PATH:$JNML_HOME
ENV IV=$HOME/neuron/iv
ENV N=$HOME/neuron/nrn
ENV CPU=x86_64
ENV PATH=$PATH:$IV/$CPU/bin:$N/$CPU/bin
ENV NEURON_HOME=$N/$CPU
ENV C302_HOME=$HOME/CElegansNeuroML/CElegans/pythonScripts/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$PYTHONPATH:$C302_HOME:$SIBERNETIC_HOME

# Not working with --chown=$USER:$USER
COPY ./master_openworm.py $HOME/master_openworm.py
RUN sudo chown $USER:$USER $HOME/master_openworm.py
