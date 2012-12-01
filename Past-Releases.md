# Past releases of the OpenWorm project

## Release 2 (completed) October 2011 to April 2012

Our major goal for this release was to integrate the work we have done in release one to do a detailed simulation of a body wall muscle cell, MDL08 (pictured below).  While we did not complete all of the epics we set out for ourselves, we made significant progress in all of them, and learned a lot in the process.  See the [[Roadmap|current Roadmap]] for more information on where we are now.

https://docs.google.com/uc?id=0B_t3mQaA-HaMZjg4MjcwODMtYzkwYy00ZjNlLWI2ZDktOWVjZDExOGJkMGE3&export=download&hl=en_US&.png

This muscle cell receives input from 8 motor neurons:

- AS01
- AS02
- DA01
- DA02
- DB01
- DD01
- SMDDL
- SMDDR

We want to combine the physical simulator, running PCI SPH, that should model the walls of the muscle cell and the force pulling on those walls when the muscle is active, with the cell membrane excitability simulator, (e.g., the Hodgkin Huxley simulator).  In order to ensure that our simulation is returning results that match reality, we will tune the significant number of parameters in our simulation using a genetic algorithm.

### Component: Genetic Algorithm

- **EPIC-1**  As a user, I want to use a genetic algorithm to fit the parameters of the muscle cell and motor neurons to real data

### Component: Simulation Engine

- **EPIC-2**  As a user, I want to run a model developed in NeuroML on our simulation engine to be able to run NeuroML models on the Amazon cloud

- **EPIC-3** As a user, I want to be able to run a simulation that includes muscle cell physics as well as muscle cell membrane excitability.

### Component: Worm Browser

- **EPIC-4**  As a user of the simulation engine, I want a browser-based visualization to show me the muscle cell output

### Component: Database

- **EPIC-5**  As a model builder, I want the best definition of the muscle cell model and motor neurons
- **EPIC-6**  As a model builder, I want to have a target output of the muscle cell.

### Component: Website

- **EPIC-7**  As a visitor to openworm.org, I want to be impressed with the professionalism of the project and want to contribute

### Component: Kickstarter

- **EPIC-8** As an open worm team member, I want to launch a fundraising campaign to raise money for the project

[A more complete document describing our plans for release 2 is available](http://bit.ly/oPTK4Q).  

----

## Release 1 (completed) May 2011 - September 2011

We have set a completed a successful release 1 in September.  It included the following features:

- Multi-algorithm simulation engine
- Create a generic architecture for combining algorithms operating at different time scales on different models
- Create [conductance-based simulator](http://www.scholarpedia.org/article/Conductance-based_models) using [OpenCL](http://en.wikipedia.org/wiki/OpenCL)
- Create a [smoothed particle hydrodynamics (SPH)](http://en.wikipedia.org/wiki/Smoothed-particle_hydrodynamics) simulator.
- Use the simulation engine architecture to combine these two algorithms to prove its generality and ability to cross algorithmic domains
- Neuron database
- Use the [Virtual Worm](http://caltech.wormbase.org/virtualworm/) Blender files to create a NeuroML compartmental description of the 302 neurons
- Combine knowledge about the [synaptic structure of the neuronal network](http://www.wormatlas.org/neuronalwiring.html) with the compartmental description
- Combine knowledge about the [ion channel structure of the neuronal network](http://j.mp/remL8E) with the compartmental description
- Worm browser
- Build a 3D interactive visualization of the Virtual Worm Blender files, akin to the [Google Body Browser](http://bodybrowser.googlelabs.com/)

### Simulation Engine ([source](http://code.google.com/p/openworm/source/checkout?repo=simulationengine))

- As a developer, I would like a simulation engine prototype that provides a design proof of concept
- As a developer, I want an alpha kernel for neuronal simulation for the prototype.
- As a developer, I want a first draft of a simulation engine design
- As a product manager, I want to see a working prototype of the SPH algorithm working with the existing [CyberElegans](http://www.youtube.com/watch?v=Ek49JSAiKjY) code
- As a product manager, I want a initial test implementation example of the SPH algorithm implemented as a solver
- As a developer, I want a simple test harness to function as client for the simulation engine prototype to ensure everything is working.
- As a developer, I would like to have a prototype of a solver service, using the HH OpenCL alpha kernel.

### Neuron Database ([source](http://code.google.com/p/openworm/source/checkout?repo=neuroml))

- As a developer, I want the Virtual Worm Blender files to include details about synapses so simulatable NeuroML can be produced
- As a developer, I want to be able to convert the Virtual Worm meshes for neurons into [complete simulation ready NeuroML descriptions of the neurons](CElegansNeuroML)

### Worm Browser ([demo](http://j.mp/q1b5le) [source](http://j.mp/pWgxkv))

- As a user I want to visualize 3D models of the worm in the browser
- As a user, I want to have GUI controls to zoom in and out of the worm
- As a user, I want to drag the worm using "cylindrical mouse orbit" like google body browser
- As a product manager, I want an example of a Unity3D web player that can visualize the Virtual Worm blender files to mitigate risk
- As a developer, I want to have the 3D models of the worm prepared in a suitable format so they can be visualized in the Web Browser
- As a user, I want to use a slider to smoothly make systems in the worm transparent

[A more complete document describing our plans for release 2 is available](http://bit.ly/oPTK4Q).  