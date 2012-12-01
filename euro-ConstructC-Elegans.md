# Introduction to using the neuroConstruct project containing the CElegans NeuroML model

# Introduction

The NeuroML conversion of the [[Virtual Worm Blender Files|VirtualWorm Blender files]] has been imported into a [neuroConstruct](http://www.neuroConstruct.org) project.

This page provides instructions for obtaining the latest version of neuroConstruct, getting the latest CElegans project and generating/visualising the cells and connections. 


# Install the latest neuroConstruct

First, get the latest version of neuroConstruct. While there are binary installers available on the neuroConstruct download page, it's best to use the latest version of this application from the Subversion repository, as this will most likely be the version in which the CElegans project was last saved.

Get the latest version of Subversion from http://subversion.apache.org. Windows users might just want to download the Explorer plugin [TortoiseSVN](http://tortoisesvn.net/downloads.html). 

The main neuroConstruct code can be checked out with the command:
    svn co svn://87.106.103.176:3999/neuroConstruct/trunk neuroConstruct
After the first successful checkout, run 
        ./updatenC.sh
on Linux/Mac, or for Windows:
        updatenC.bat 
in the neuroConstruct directory, as there are some NeuroML files needed
that reside at the NeuroML Sourceforge repository. 

Running the `updatenC` command in future (as opposed to just `svn update`) will ensure a consistent set of
neuroConstruct source, NeuroML files and example models.

The Java code needs to be compiled and run with the command 
    ant run
so install Ant too: http://ant.apache.org. 

Alternatively you should be able to compile and run neuroConstruct using: 
    ./nC.sh -make
    ./nC.sh 
on Linux/Mac, or for Windows:
    nC.bat -make
    nC.bat

without Ant. Contact p.gleeson -at- ucl.ac.uk if there you have any problems with this.


# Getting the latest CElegans neuroConstruct project

The latest CElegans project is being hosted on Github [here](https://github.com/openworm/CElegansNeuroML). You have a number of options for getting the project:

## A) Zip file with latest project=

Get a zipped file with the project [here](https://github.com/openworm/CElegansNeuroML/zipball/master). Unzip this and go to the `CElegans` folder.

## B) Read only copy of latest project

Install [Git](https://help.github.com/articles/set-up-git) and get a read only clone of the Git repository:
    git clone git://github.com/openworm/CElegansNeuroML.git
    cd CElegansNeuroML/CElegans
You'll always be able to retrieve the latest version of the project with
    git pull

## C) Fork the project=

Fork yourself a personal copy of the project repository. Go to https://github.com/openworm/CElegansNeuroML for more details.


# Open the project

Run neuroConstruct as outlined above (`ant run` or `nC.bat`/`nC.sh`). In the main menu select **File** -> **Open** and browse to the location of **CElegans.ncx**. Select this file and press **Open**.

The project may take up to 20 seconds to load. When it does load, try clicking on one of the cells in the **Cell Types in project** box, e.g. ADAL. This will take you to the **Cell Types** tab and show a summary of the cell's electrical properties (note: these are not yet matched to the real electrophysiological properties of Celegans cells!) and the number of segments in the cell.

Click on **View/edit morphology** and this will visualise the cell in 3D, see below.

https://github.com/openworm/CElegansNeuroML/raw/master/CElegans/images/ADAL_nC.png

Now generate a network of all 302 neurons. Go to tab **Generate** and press **Generate cell positions and connections**. Now go to tab **Visualise** and press **View** with **Latest Generated Positions** selected in the drop down box.

The image below shows the generated network. 

https://github.com/openworm/CElegansNeuroML/raw/master/CElegans/images/CElegans_nC.png

TODO: more on [Simulation Configurations](http://www.neuroconstruct.org/docs/Glossary_gen.html#Simulation%20Configuration)...

# Check the project

In addition to being able to generate and view the project through the main GUI, a number of Python scripts are provided to test the configuration of the project. These scripts access functionality in the Java implementation of neuroConstruct by using [Jython](http://www.jython.org). More details on the Python interface to neuroConstruct can be found [here](http://www.neuroconstruct.org/docs/python.html).

A script to test various aspects of the project is `CheckProject.py`. Running this generates a number of the Simulation Configurations in succession and checks that the expected numbers of cells and connections are created:

    cd pythonScripts
    ~/neuroConstruct/nC.sh -python CheckProject.py

# Generate NeuroML from the project

A NeuroML file containing the structure of the cells & all connections can be generated in two ways:

## Through the GUI

After generating the network in the GUI as outlined above, go to tab **Export**, click on **Generate all NeuroML scripts**. To have a single file with all the NeuroML for cells, channels and network connections, select **Generate single NeuroML Level 3 file**.

## Using a Python script

Go to folder `pythonScript` and run:

    ~/neuroConstruct/nC.sh -python GenerateNeuroML.py

Interested in helping out?  Check out the OpenWorm [Getting Started page](http://www.openworm.org/index.html#/getstarted) and the [Contact page](http://www.openworm.org/index.html#/contacts).