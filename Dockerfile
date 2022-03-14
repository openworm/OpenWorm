FROM ubuntu:18.04

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
  libxext-dev libncurses-dev python-dev mercurial \
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

USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

#### TODO: check that this is the best way to switch to py3...
RUN  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
RUN  sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10


################################################################################
########     Install NEURON simulator

RUN sudo pip install neuron==7.8.1


################################################################################
########     Install pyNeuroML for handling NeuroML network model

RUN git clone https://github.com/NeuroML/pyNeuroML.git && \
  cd pyNeuroML && \
  git checkout master  && \
  sudo python3 setup.py install

# TODO remove this line after we have better dependency management.  The
# current version of gitpython requires python >= 3.7, which is newer than the
# python included in the base image. Therefore, we manually install an older
# gitpython to be used with OpenWormData.
# See https://github.com/openworm/OpenWorm/pull/316
RUN sudo pip install 'gitpython==2.1.15' markupsafe

RUN git clone https://github.com/openworm/PyOpenWorm.git && \
  cd PyOpenWorm && \
  git checkout ow-0.9 && \
  sudo apt-get install -y python3-cffi && \
  sudo python3 setup.py install && \
  pow clone https://github.com/openworm/OpenWormData.git


################################################################################
########     Install c302 for building neuronal network models

RUN git clone https://github.com/openworm/c302.git && \
  cd c302 && \
  git checkout ow-0.9.1 && \
  sudo python3 setup.py install


################################################################################
########     Install Sibernetic for the worm body model

RUN git clone https://github.com/openworm/sibernetic.git && \
  cd sibernetic && \
  git checkout ow-0.9.1 # fixed to a specific branch

RUN cp c302/pyopenworm.conf sibernetic/   # Temp step until PyOpenWorm can be run from any dir...


################################################################################
########     Set some paths//environment variables

ENV JNML_HOME=$HOME/jNeuroML
ENV PATH=$PATH:$JNML_HOME

ENV C302_HOME=$HOME/c302/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$PYTHONPATH:$HOME/c302:$SIBERNETIC_HOME

# Not working with --chown=$USER:$USER
COPY ./master_openworm.py $HOME/master_openworm.py
RUN sudo chown $USER:$USER $HOME/master_openworm.py


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
    sed -i -e "s/lpython2.7/lpython3.6m/g" makefile && \
    sed -i -e "s/n2.7/n3.6/g" makefile && \
    make clean && make all  # Use python 3 libs

# intel i5, hd 5500, linux 4.15.0-39-generic
# ./Release/Sibernetic -f worm -no_g device=CPU    190ms
# ./Release/Sibernetic -f worm -no_g device=GPU    150ms (initialization takes some time)

# Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz, linux 4.4.0-139-generic
# ./Release/Sibernetic -f worm -no_g device=CPU    60ms
#
# after installing the nvidia driver used in host:
## wget http://us.download.nvidia.com/tesla/390.30/nvidia-diag-driver-local-repo-ubuntu1604-390.30_1.0-1_amd64.deb
## sudo dpkg -i nvidia-diag-driver-local-repo-ubuntu1604-390.30_1.0-1_amd64.deb
## sudo apt-key add /var/nvidia-diag-driver-local-repo-390.30/7fa2af80.pub
## sudo apt-get update
## sudo apt-get install -y cuda-drivers
# ./Release/Sibernetic -f worm -no_g device=GPU    37ms


RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc

RUN pip list

RUN echo "Built the OpenWorm Docker image!"
