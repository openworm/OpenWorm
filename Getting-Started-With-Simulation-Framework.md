# Instructions on how to get started with the Simulation Framework

<wiki:toc max_depth="2" />
# Introduction

At the heart of the Open Worm Project is the Simulation Framework. The Simulation Framework is a multi-algorithm, multi-scale simulation platform engineered to support the simulation of complex biological systems and their environment. The choice to build the Simulation Framework came after an analysis of the requirements for a platform to support a full-scale simulation of the Caenorhabditis Elegans and potentially even more complex organisms in time to come. Beside the functional requirements the Simulation Framework goal is to move away from the common monolithic approach usually found in academic projects and its architecture reflects the open source spirit of the Open Worm Project where people are welcome to contribute by adding functionalities to existing plugins or writing new ones without having to deal with uncool mountains of code.

This page explains how to get started playing with the Simulation Framework.  You can check out the SimulationFrameworkConcepts page for more information on its architecture.

# Current progress

We are currently coming out of a prototype phase of the Simulation Framework where we proved the main concepts and the technology stack by simulating the parallel firing of 302 Hodgkin-Huxley neurons.

# Future progress

Our next step will be to integrate the Physics Simulation (see GettingStartedWithPhysics for additional info) with the Neuronal Simulation to deal with multiple-algorithms synchronization.

# Video of the prototype

<wiki:gadget url="http://hosting.gmodules.com/ig/gadgets/file/115213873503001037481/youtube_player_widget.xml" height="300" up_height="300" up_width="400" width="400" up_id="94Q_HKK0OCA" />

This video shows the current trivial front-end for the simulation framework which served the purpose of a simple test. In the video one of the 302 neurons (simulated in parallel on GPU native kernel via OpenCL) is displayed and by changing the external current applied the spike shape and firing rate is updated. This rather basic setup is just meant to be a proof of concept of the rather complex technology cocktail involved behind the scene (see SimulationFrameworkConcepts for more details).

# Live Demo

Coming Soon...

## Downloading

The Simulation Framework prototype bundles are packed as a single PAR available here:
[To deploy it to Virgo Web Server add the PAR file to the pickup directory or use Virgo Admin console to do it.

More information is [https://docs.google.com/document/d/1UPfS5UbQ9z61EJ4Uf6saivSy8IR4JHoyQO38FY66ifE/edit?hl=en_GB available here](http://simulationengine.openworm.googlecode.com/hg/Deployables/org.openworm.simulationengine-1.0.0.par]).

## Building from Sources

**[Instructions for setting up the OpenWorm Simulation Engine on Eclipse Juno](https://docs.google.com/document/d/1UPfS5UbQ9z61EJ4Uf6saivSy8IR4JHoyQO38FY66ifE/edit) **

If you have any questions email matteo@openworm.org

# Resources

- [- [http://cxf.apache.org/dosgi-spring-dm-demo-page.html](http://static.springsource.com/projects/dm-server/1.0.x/programmer-guide/htmlsingle/programmer-guide.html#developing-applications-dependencies])

- [- [http://www.eclipse.org/virgo/documentation/virgo-documentation-2.1.1.RELEASE/docs/virgo-getting-started/html/index.html](http://www.eclipse.org/virgo/documentation/virgo-documentation-2.1.1.RELEASE/docs/virgo-programmer-guide/html/index.html])

Interested to participate?  Check out our [Getting Started page](http://www.openworm.org/index.html#/getstarted) and our [Contact page](http://www.openworm.org/index.html#/contacts).