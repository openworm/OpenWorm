FROM neuralensemble/simulationx:py2
MAINTAINER stephen@openworm.org

#Still needs to have -lOpenCL not fail
#RUN apt-get update && apt-get install -y libglu1-mesa-dev freeglut3-dev mesa-common-dev opencl-headers libnuma1
#
#RUN cd / && git clone https://github.com/openworm/sibernetic.git && cd sibernetic \
#    && make clean && make all

#RUN cd / && git clone https://github.com/openworm/PyOpenWorm.git && cd PyOpenWorm \
#    && python setup.py install

#RUN cd / && git clone https://github.com/openworm/ChannelWorm.git && cd ChannelWorm \
#   && python setup.py install

#RUN apt-get update && apt-get install -y opencv libhdf5-dev

#RUN cd / && git clone https://github.com/openworm/open-worm-analysis-toolbox.git && cd open-worm-analysis-toolbox \
#    && python setup.py install

RUN apt-get update && apt-get install -y libxml2-dev libxslt-dev zlib1g-dev openjdk-7-jre

RUN cd / && git clone https://github.com/openworm/CElegansNeuroML.git && cd CElegansNeuroML \
    && pip install -I airspeed==0.5.4dev-20150515 && python setup.py install

ENV NEURON_HOME=$VENV/x86_64

#ADD master_openworm.py
