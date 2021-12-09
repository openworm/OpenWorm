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


################################################################################
########     Install Intel OpenCL libraries needed for Sibernetic

RUN apt-get update && apt-get install -y --no-install-recommends unzip wget xz-utils

RUN mkdir intel-opencl-tmp && \
  cd intel-opencl-tmp && \
  mkdir intel-opencl && \
  wget http://registrationcenter-download.intel.com/akdlm/irc_nas/11396/SRB5.0_linux64.zip && \
  unzip SRB5.0_linux64.zip && \
  tar -C intel-opencl -Jxf intel-opencl-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-devel-r5.0-63503.x86_64.tar.xz && \
  tar -C intel-opencl -Jxf intel-opencl-cpu-r5.0-63503.x86_64.tar.xz && \
  cp -R intel-opencl/* / && \
  ldconfig && \
  cd .. && \
  rm -r intel-opencl-tmp

################################################################################
########     Update/install essential libraries

RUN apt-get update && apt-get install -y --no-install-recommends \
  make \
  git \
  g++ \
  sudo \
  ffmpeg \
  libavcodec-dev \
  libavutil-dev \
  openjdk-8-jdk \
  libxext-dev \
  freeglut3-dev \
  libglu1-mesa-dev \
  libglew-dev

RUN usermod -a -G video $USER

# XXX: Not actually sure what this is for...
RUN cp -R /opt/intel/opencl/include/CL /usr/include/ && \
  apt install -y ocl-icd-opencl-dev
# sudo ln -s /opt/intel/opencl/libOpenCL.so.1 /usr/lib/libOpenCL.so

# Install python-dev separately and after the packages above so changes don't
# bust the cache and force everything to be reinstalled.
#
# The python version has a dot which some versions of apt-get interpret as a
# regex or glob, so we use regex anchors to make sure we don't match a
# libpython-dev package instead, which wouldn't install the pythonX.Y-config
# script we need
ENV PYTHON_VERSION 3.8
# FOR SOME REASON "-specs=/usr/share/dpkg/no-pie-compile.specs" gets added to
# CFLAGS even though libdpkg-perl, which provides this file, is not
# installed...anway, we install it here
#
# for some reason, we need to install python3-distutils in addition to
# pythonX.Y-venv
RUN apt-get update && apt-get install -y --no-install-recommends \
  "^python${PYTHON_VERSION}-dev$" \
  python${PYTHON_VERSION}-venv \
  python${PYTHON_VERSION}-distutils \
  libdpkg-perl

# Get the base name of the version of Python installed so later steps can use
# rather than trying to detect the right one to use. 
ENV PYTHON_ABIFLAGS ''
ENV PYTHON_BASENAME python${PYTHON_VERSION}${PYTHON_ABIFLAGS}
ENV PYTHON_LIBDIR_BASENAME python${PYTHON_VERSION}
ENV PYTHON_CONFIG /usr/bin/${PYTHON_BASENAME}-config
# Make sure the python config script exists
RUN echo PYTHON_CONFIG=$PYTHON_CONFIG
RUN test -x $PYTHON_CONFIG

USER $USER
ENV HOME /home/$USER
WORKDIR $HOME

RUN $PYTHON_BASENAME -m venv env
ENV VENV $HOME/env
ENV PIP $VENV/bin/pip
ENV PYTHON $VENV/bin/python
ENV PYTHON_LIBDIR $VENV/lib/$PYTHON_LIBDIR_BASENAME
# Make sure the virtualenv python libdir exists
RUN test -d $PYTHON_LIBDIR
RUN $PIP install --upgrade pip


################################################################################
########     Install NEURON simulator

RUN $PIP install 'matplotlib<=3.4.1'
RUN $PIP install neuron==7.8.1


################################################################################
########     Install pyNeuroML for handling NeuroML network model

RUN git clone https://github.com/NeuroML/pyNeuroML.git && \
  cd pyNeuroML && \
  git checkout development && \
  $PIP install .


################################################################################
########     Install c302 for building neuronal network models

# TODO remove this line after we have better dependency management.  The
# current version of gitpython requires python >= 3.7, which is newer than the
# python included in the base image. Therefore, we manually install an older
# gitpython to be used with OpenWormData.
# See https://github.com/openworm/OpenWorm/pull/316
RUN sudo pip install 'gitpython==2.1.15'

RUN git clone https://github.com/openworm/c302.git && \
  cd c302 && \
  git checkout master && \
  $PIP install .

RUN $PYTHON -m owmeta_core.cli bundle remote --user add ow 'https://raw.githubusercontent.com/openworm/owmeta-bundles/master/index.json'

# Fetch the bundle now so executions go by more quickly
# TODO: Externalize the bundle name and version so both C302 and Dockerfile can be sure to stay in sync
RUN $PYTHON -m owmeta_core.cli bundle fetch --bundle-version=6 openworm/owmeta-data 


################################################################################
########     Set some paths//environment variables

ENV C302_HOME=$HOME/c302/c302
ENV SIBERNETIC_HOME=$HOME/sibernetic
ENV PYTHONPATH=$PYTHON_LIBDIR/site-packages:$HOME/c302:$SIBERNETIC_HOME
ENV NEURON_HOME $VENV


################################################################################
########     Build Sibernetic

RUN sudo apt-get install libswscale-dev 
RUN git clone https://github.com/openworm/sibernetic.git && \
    cd sibernetic && \
    git checkout mwatts-test  && \
    make clean && FFMPEG=true make debug  # Use python 3 libs.

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

# We shouldn't really need this typing.py anyway, but it breaks when running
# the sibernetic_c302.py script on Python 3.7. We can't use pip either since it
# has the same problem as sibernetic_c302.py
# See https://stackoverflow.com/a/58067012/638671
RUN rm $PYTHON_LIBDIR/site-packages/typing.py

RUN echo '\n\nalias cd..="cd .."\nalias h=history\nalias ll="ls -alt"' >> ~/.bashrc
