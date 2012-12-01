# How to run an example in the NEURON simulation engine

# Introduction

This tutorial will take you through the process of installing the [NEURON simulation engine](http://www.neuron.yale.edu/neuron/) within a [Python](http://www.python.org/) environment, loading a NeuroML example running the Hodgkin-Huxley equations, and getting some results out of the simulation.  This is useful to compare results with the [[Getting Started With Simulation Framework|Simulation Engine platform we are building within the Open Worm project]].

Python and NEURON go great together.  [Have a look at Hines et al., 2009, which describes why.](http://www.ncbi.nlm.nih.gov/pubmed/19198661)

# Details

## Installation

You have two main options to get an environment running -- use an Amazon EC2 AMI that we provide, or install Python + NEURON on your own environment

### Amazon EC2 AMI

To avoid any installation, you can use our public 64-bit AMI available on Amazon EC2 (only available on US-EAST)

- Name: Open Worm NEURON Python environment 1.1
- ID: ami-c16ea2a8
- Description: An Amazon Linux instance with NEURON 7.1 enabled through Python 2.6

This will launch an Amazon Linux instance with NEURON 7.1 enabled through Python 2.6

### Self Installation

### = Installing Python =

### == For Windows ==

- Install Cygwin
- Be sure to add {{{g++}}} and {{{make}}} and {{{libncurses-devel}}} under the "devel" category to the set of tools installed by cygwin during the setup screen.
- Be sure to add {{{python}}} and {{{python-numpy}}} under the "python" category to the set of tools installed by cygwin during the setup screen.

### == For Non-windows ==

1. [Download and install Python](http://www.python.org/download/) 2.7 (not 3 -- won't work for next step)
- Python is a flexible language for scripting the use of NEURON
- Open a command prompt or shell and type 'python' to see if it installs appropriately
1. [Download and install setuptools](http://pypi.python.org/pypi/setuptools)
- setuptools will easily enable you to install additional packages for Python
- One simple way to do this is to run the IDLE python IDE (comes with Python), click File->Open on the downloaded [ez_setup.py](http://peak.telecommunity.com/dist/ez_setup.py), and hit F5 to run it.
- Be sure to add the Scripts directory under your Python installation directory to your PATH environment variable, if you haven't already done so.
1. [Download and install pip](http://www.pip-installer.org/en/latest/installing.html)
- pip will easily enable you to download additional packages for Python, and will leverage setup tools to install those packages locally.
- One simple way to do this is to [download the source](http://pypi.python.org/packages/source/p/pip/pip-1.0.tar.gz), unpack, and do {{{python setup.py install}}} inside the directory.

### = Installing NEURON =

- [Download and install NEURON](http://www.davison.webfactional.com/notes/installation-neuron-python/)
- Although this step is involved, its the only way to call NEURON from a python script, which is VERY useful.
- Follow the [instructions here](http://www.davison.webfactional.com/notes/installation-neuron-python/) for doing this.
- The whole purpose of compiling this yourself is to be able to add the {{{--with-nrnpython}}} flag in the {{{./configure --prefix=`pwd`}}} step.
- This enables the Python interface to NEURON.  Don't leave this bit out!
- Because compiling is involved, this step may take a significant amount of time (1 hour or more)

## Basic NEURON Python example

*This section is an excerpt from [Hines et al, 2009.](http://www.ncbi.nlm.nih.gov/pubmed/19198661)*

In Python,  NEURON is started when you import neuron:

    $ python 
    >>> from neuron import h
    NEURON -- VERSION 7.0 (228: fbb244f333a9) 2008-11-25
    Duke, Yale, and the BlueBrain Project -- Copyright 1984-2008
    See http://www.neuron.yale.edu/credits.html

The h object that we import from the neuron module is the
principal interface to NEURON’s functionality. h is a !HocObject instance, and has two main functions. First, it gives access to the top-level of the Hoc interpreter, e.g.:

    >>> h('create soma') 
    >>> h.soma 
    < nrn.Section object at 0x8194080>

Second, it makes any of the classes defined in Hoc available to
Python: 

    >>> stim = h.IClamp(0.5, sec=h.soma) 

Note that the soma section created through the Hoc interpreter appears in Python as a Section object. We can also create Sections directly in Python, e.g.

    >>> dend = h.Section() 

These two section objects are entirely equivalent, the only
difference being that the name “dend” is not accessible within the Hoc interpreter. In addition to the !HocObject class (and through it, any class defined in Hoc) and the Section class, the Python neuron module also provides the Segment, Mechanism and !RangeVariable classes.

For new users of NEURON with Python, a convenient starting place for help is Python online help, provided through the global function help, which takes one argument, the object on which you would like help:

    >>> import neuron 
    >>> help(neuron) 
    
    Help on package neuron:
    NAME 
         neuron 
    FILE
         /usr/lib/python2.5/site-packages/neuron/ 
             __init__.py
    DESCRIPTION 
         neuron 
         ======
         For empirically-based simulations of 
             neurons and networks of neurons in 
             Python.
    
         This is the top-level module of the official 
             python interface to the NEURON simulation 
             environment (http://www.neuron.yale. 
             edu/neuron/).
    
    For a list of available names, try 
             dir(neuron).
    […]

## Running a simple simulation

*This section is a modified excerpt from [Hines et al, 2009.](http://www.ncbi.nlm.nih.gov/pubmed/19198661)*

    from neuron import h
    
    # create pre-and post-synaptic sections
    pre = h.Section()
    post = h.Section()
    
    for sec in pre,post: 
        sec.insert('hh')
    
    # inject current in the pre-synaptic section
    stim = h.IClamp(0.5, sec=pre)
    stim.amp = 10.0
    stim.delay = 5.0
    stim.dur = 5.0
    
    # create a synapse in the pre-synaptic section
    syn = h.ExpSyn(0.5, sec=post)
    
    # connect the pre-synaptic section to the 
    # synapse object
    nc = h.NetCon(pre(0.5)._ref_v, syn, sec=pre)
    nc-weight[0] = 2.0
    
    vec={}
    for var in 'v_pre', 'v_post', 'i_syn', 't':
        vec[var] = h.Vector()
    
    # record the membrane potentials and 
    # synaptic currents
    vec['v_pre'].record(pre(0.5)._ref_v)
    vec['v_post'].record(post(0.5)._ref_v)
    vec['i_syn'].record(syn._ref_i)
    vec['t'].record(h._ref_t)
    
    # run the simulation
    h.load_file("stdrun.hoc")
    h.init()
    h.tstop = 20.0
    h.run()
    
    # check the values on command line
    list(vec['v_pre'])
    list(vec['v_post'])
    list(vec['i_syn'])
    list(vec['t'])
    

## Loading a NeuroML example

### Amazon EC2 AMI

If you are using the image described above, you should do the following:

    cd /home/ec2-user/neuron/nrn-7.1/share/nrn/lib/python/NeuroML2nrn/
    python -i test.py

This will load up Level2.xml.  You can run a simulation with this NeuroML file with the following commands within Python:

    vec={}
    for var in 'v_soma', 't':
        vec[var] = h.Vector()
    
    # record the membrane potentials and 
    # synaptic currents
    vec['v_soma'].record(h.Soma(0.5)._ref_v)
    vec['t'].record(h._ref_t)
    
    # run the simulation
    h.load_file("stdrun.hoc")
    h.init()
    h.tstop = 20.0
    h.run()
    
    # check the values on command line
    list(vec['v_soma'])
    list(vec['t'])

### Self Installation

If you have done the self installation, follow the instructions in the [README](http://neuroml.svn.sourceforge.net/viewvc/neuroml/NeuroML2nrn/README?revision=725&view=markup) in the [NeuroML2nrn directory](http://neuroml.svn.sourceforge.net/viewvc/neuroml/NeuroML2nrn/) to set this up