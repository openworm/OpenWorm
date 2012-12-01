# This page describes where we are going with the project.

<wiki:toc max_depth="2" />

# Release 3: May 2012 - November 2012

Our [second release](PastReleases#Release_2_(completed)_October_2011_to_April_2012) pointed us in a good direction for the future, and provided some [exciting products](http://browser.openworm.org).  In release 3, we are working to produce additional products that are more easily used by the outside world.

## EPIC-1: As a user, I want to be able to mark synapses and have them integrated into the model

The user will be able to contribute to a shared knowledge space of the positions and identities of c. elegans synapses using an installation of CATMAID.  This is important because the [c. elegans connectome](CElegansNeuroML) does not currently incorporate synapse positions at all.

The project page for this epic is [available online](https://docs.google.com/document/d/14lN2jjG2thCnVyBSABbMtEWOWCXdYTCn22erb7Wxujo/edit#).  Feel free to leave comments on it!

## EPIC-2: As a developer, I want to launch the simulation engine on Amazon AWS

This could be implemented with an auto-configuration system like [Fabric](http://fabfile.org) that automatically launches AWS instances and runs an installation script on it.  This way we can control what OS / drivers are used on the target system.

## EPIC-3: As a user, I want to be able to see the body of the worm moving and changing color, driven by activity of the simulation engine (Simplified Worm)

It is important the outside users can see a visual representation of the [[Getting Started With Simulation Framework|simulation engine]] so that they can get a sense of what is going on with the project.

## EPIC-4: As a user, I want to be able to run a simulation that includes muscle cell physics as well as muscle cell membrane excitability

Here is [a diagram](https://docs.google.com/drawings/d/1zsqLZs5dunL_YUZP4uoag1OpdQTfW9m89AfgCY_7BZM/edit) that shows the roadmap for this.

## EPIC-5: As a scientist, I want a detailed written summary of the physiology we intend to include in the model

This is a document written as prose that summarizes the physiological data that is known..  This should structure the information that currently exists and show where the gaps of knowledge are. 

This is important because we want to build cells which are conductance based models.  At the moment we don't know all the channels.  This allows others to contribute what they know about this.

## EPIC-6: As a user, I want to see the optimized data matching the experimental results

This should enable the [[Getting Started With Genetic Algorithms|parameters of the muscle cell to be tuned]] with respect to real data.

## EPIC-7: As a user, I want to see a WebGL visualization of [Smoothed Particle Hydrodynamics](http://en.wikipedia.org/wiki/Smoothed-particle_hydrodynamics)

We want to be able to run the [[Getting Started With Physics|Smoothed Particle Hydrodynamics demos]] so we can see them through the browser.

# Recent presentation update

In March 2012, we presented [this update on the project](https://docs.google.com/open?id=0B_t3mQaA-HaMSjQ0YWdWVi1JYWc).

<wiki:comment>
`<wiki:gadget url="http://openworm.googlecode.com/hg/openworm-update.xml" width="640" height="480"/>`
</wiki:comment>

# Past Releases

More information on past releases are [[Past Releases|available here]].

Interested to participate?  Check out our [Getting Started page](http://www.openworm.org/index.html#/getstarted) and our [Contact page](http://www.openworm.org/index.html#/contacts).