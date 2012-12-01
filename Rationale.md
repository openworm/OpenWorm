# Why this is important.

# Introduction

If we ever hope to understand how the brain works, we should start with a predictive model that is small, and build up. 

Models are the cornerstone of science. Tools like algebra and calculus and newtonian mechanics and computer spreadsheets were advances because we could plug numbers into equations and get answers out that told us something about the world.

Unfortunately, neuroscience has few predictive models for how nervous systems work. 

Let's start by building a full simulation of a small biological system with a reasonable number of parts, but focus on capturing as much of the rich detail of that biological system as possible. 

# Details

Simulating a single cell that doesn't move (like a yeast cell) isn't going to provide us enough of a foundation to build up to more complex organisms by itself. 

In the field of neuroscience, one of the simplest organisms that are studied is the [c. elegans](http://en.wikipedia.org/wiki/Caenorhabditis_elegans). It only has 302 neurons, has a very consistent lifecycle, and is well studied. Its whole body has only 1000 cells total. With those 1000 cells it solves basic problems of feeding, mate-finding, predator and toxin avoidance using a nervous system driving muscles on a body in a complex world.

We need to represent *every cell individually*, within a spatial model that has physical forces acting on its body. The physical model would be constraining what the neurons would need to be doing--- important information for building a predictive model of the neurons. Instead of studying the neurons from the inside out as most modern neuroscience does, we'd be building the neurons based on what they need to accomplish--from the outside in.

This seems to us the only sensible starting point to creating a true biological simulation that captures enough details and has enough constraints to approximate real biology. If we can't accomplish a simulation at this humble scale, we'll never be able to do it at the massive scale of the human brain. The technology that would come out of this endeavor would be applicable to much more complex organisms down the road.

# Additional information

- Jeff Kaufman has [written up a nice summary](http://www.sccs.swarthmore.edu/users/08/cbr/news/2011-11-02.html) on the state of c. elegans simulations from the perspective of the possibility of whole brain emulation some day.
- James Pearn has [written up a good overview of the project](http://www.artificialbrains.com/openworm) over at [his site](http://artificialbrains.com) that surveys projects simulating nervous systems.

# Getting Started

Interested to participate?  Check out our [Getting Started page](http://www.openworm.org/index.html#/getstarted) and our [Contact page](http://www.openworm.org/index.html#/contacts).