# using neuroconstruct

# Introduction

Once the NeuroML file has was created using the Python Extraction script, the Open Worm team imported the file into [neuroConstruct](http://www.neuroconstruct.org), a tool designed by  [Department of Neuroscience, Physiology and Pharmacology at UCL](http://http://www.ucl.ac.uk/npp/homepage) which allowed the Open Worm project team to add ChannelML (Biophysical) properties and Network (Synaptic) properties, and export to a resulting NeuroML that features a more complete description of the C. Elegans neurons and connectome. 


# Details

**Note: these steps do not need to be repeated. Find details of how to use an existing neuroConstruct project containing the cell morphologies [here](neuroConstructCElegans).**

Open neuroConstruct:

https://docs.google.com/uc?id=0ByUDozF42qTSOWYzYzdlYmQtZDhhYy00NjQzLThkY2MtZDgzZTllNmMwNTA1&export=download&hl=en_US&.png

Import the file created by the Python Extraction Script (ala Sergey Khayrulin):

https://docs.google.com/uc?id=0ByUDozF42qTSNjExNjUyNzktY2ZmNC00MmY0LWJkN2YtYjUxZGNhOGEwYWZh&export=download&hl=en_US&.png

We added a Region as the Worm Body but we plan on later revisions to break down the Worm into individual segments.

Add each Cell as a Cell group:

https://docs.google.com/uc?id=0ByUDozF42qTSOTQzMTc4YmUtNTdmNy00NDIyLWIwZjctYzY1Njg0MzFmNTRi&hl=en_US.png

Add the Cell Mechanisms:

https://docs.google.com/uc?id=0ByUDozF42qTSMmFjZDhiMzctMzg3NS00Y2U4LWJkYzktMzg2ZGMxNzM1YTRm&hl=en_US.png

Create the Network:

https://docs.google.com/uc?id=0ByUDozF42qTSYjc3NDVjNWMtYTY1Yy00ZDE1LWE2NTUtNDUxZTY3Njk5MDkw&hl=en_US.png

Connect the Synapses through the Visualization tab and then Generate the Cell Positions and Connections:

https://docs.google.com/uc?id=0ByUDozF42qTSNDc2YTNiZjYtMzBjNy00MGY4LWJjMTctMTc1ZTQyMTExMWYy&hl=en_US.png

Finally, once generated, export the NeuroML for consumption by the simulation engine:

https://docs.google.com/uc?id=0ByUDozF42qTSOGFlMWJlYjUtOTFmMC00ODE0LTlkMDgtMjY2OWRjOTlhZmI2&hl=en_US.png

# Available Data

You can find details of the latest neuroConstruct project for the C Elegans project in the [here](http://code.google.com/p/openworm/wiki/neuroConstructCElegans).

# Next Step

Now that the Open Worm team has the NeuroML in a well defined manner, we will start importing the NeuroML into the simulation engine to define the Neuron position, connections to other Neurons and other cells (muscles), and the biophysical properties that define how the neurons will work within the simulation. 

Along with the simulation import, we are working on how to define the muscle cells so we have a complete picture of the Neuron and Muscle anatomy and physiology. In the more long term, interneurons, and sensory neurons will be defined as well. 