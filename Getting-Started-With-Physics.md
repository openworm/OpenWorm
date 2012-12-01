# Overview into the physics engine

# Introduction

We have surveyed the different engines for implementing the kind of soft body physics we are interested in having for the Open Worm project.

# Initial version of mechanical model

<wiki:gadget url="http://hosting.gmodules.com/ig/gadgets/file/115213873503001037481/youtube_player_widget.xml" height="480" up_height="480" up_width="640" width="640" up_id="3uV3yTmUlgo" />

A talented team of researchers at the [A.P. Ershov Institute of Informatics Systems SB RAS, Lab. of Complex Systems Simulation](http://db.iis.nsk.su/structure/structure.asp?StructName=70&lang=eng), consisting of [Andrey Palyanov](http://ru.linkedin.com/pub/andrey-palyanov/20/201/611),  [Sergey Khayrulin](http://www.linkedin.com/pub/sergey-khayrulin/31/2a7/452), and [Alexander Dibert](http://j.mp/oqZ3Xz) developed an initial neuromechanical model of the c. elegans in 3D (seen above).  They have now begun working together with the Open Worm project to incorporate greater biological realism into their model, simulating the soft body of the c. elegans rather than a rigid body, and to break the monolithic code base into a [[Getting Started With Simulation Framework|simulation engine that can be distributed across multiple machines]].

# Latest physics solver demo

<wiki:gadget url="http://hosting.gmodules.com/ig/gadgets/file/115213873503001037481/youtube_player_widget.xml" height="480" up_height="480" up_width="640" width="640" up_id="jHksm0QKWPE" />

We are currently working on implementing an algorithm called Predictive-corrective incompressible Smoothed Particle Hydrodynamics (PCISPH) (see [this reference for more](http://j.mp/pQS1y3)).We have [released a demo version of the physics solver online](http://j.mp/ri8VR8).  We have not yet incorporated the [[Virtual Worm Blender Files|worm anatomy]] into this solver, although this will be the next step.

If you are running Windows, you can [download](http://j.mp/nBgWu6) a current version of our alpha implementation of PCISPH [here](http://j.mp/nBgWu6).

The source code for this demo is [available online here](http://https://github.com/openworm/Smoothed-Particle-Hydrodynamics).

# References

We would also recommend the following references on PCISPH:

- [Boundary handling and adaptive time-stepping for PCISPH](http://j.mp/nkAbUF)
- [INCOMPRESSIBLE FLUID SIMULATION AND ADVANCED SURFACE HANDLING WITH SPH](http://j.mp/nLPwM0)

If you have trouble getting a hold of any of these documents, or have any questions regarding this, let us know.  

Interested to participate?  Check out our [Getting Started page](http://www.openworm.org/index.html#/getstarted) and our [Contact page](http://www.openworm.org/index.html#/contacts).