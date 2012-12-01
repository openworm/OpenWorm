# Getting started working with the NeuroML files

# Introduction

This page will introduce you to the NeuroML files, the scripts that generate them, how to use NeuroConstruct to create the ChannelML and Network.

We have developed some python scripts to generate NeuroML files from the [Virtual Worm](http://caltech.wormbase.org/virtualworm/) Blender files.  You can find the source code [here](http://code.google.com/p/openworm/source/checkout?repo=neuroml).

From the Blender NeuroML output which produces the physical model of the Neuron through Cartesian points, we source the resulting NeuroML files into [NeuroConstruct](http://www.neuroconstruct.org), a tool designed by  [Department of Neuroscience, Physiology and Pharmacology at UCL](http://http://www.ucl.ac.uk/npp/homepage) that allows the Open Worm project team to add ChannelML (Biophysical) properties and Network (Synaptic) properties, and export to a resulting NeuroML that features a more complete description of the C. Elegans neurons and connectome. 

The next step is to use the NeuroML as the source (data base) to describe the neural network and neural properties of the C. Elegans simulation. By reading the NeuroML file(s) each time the simulation is ran, we can make modifications to the NeuroML to refine and tune the neural network without having to change any coding in the sumulation engine. NeuroML gives us the ability to add additional features as more information becomes available without having to change code.


# Details

## What is NeuroML?

[NeuroML](http://www.neuroml.org/) is an XML (Extensible Markup Language) based model description language that aims to provide a common data format for defining and exchanging models in computational neuroscience. The focus of NeuroML is to provide a common means to describe anatomy,  biophysical properties and the interconnection of networks (e.g. Synaptical connections) of real neurons.

## NeuroML, The Beginning - Motor Neurons

[Motor_Neurons.zip](http://code.google.com/p/openworm/downloads/detail?name=Motor_Neurons.zip) is a description of 109 C. Elegans Motor Neurons with 60 Neurons connected to one another including cell, synaptic mechanisms and network connections. Please note that in cases of the Synaptic connections and cell mechanisms, closest proximity and defaults were used at this time. The Zip file linked here is the full [NeuroConstruct](http://www.neuroconstuct.org) (version 1.4.1) project.

The process to create the NeuroML for C. Elegans is to extract the anatomical features from the Blender file created by Christian Grove ([Worm Atlas](http://www.wormatlas.org)) using the [Python script created by Open Worm team member Sergey Khayrulin](BlenderToNeuroMLConversionAlgorithm). Sergey's script extracts the vertices and creates a full NeuroML file with vertex positions and cable information. The NeuroML created by Sergey's Python script is then Imported into [NeuroConstruct](http://www.neuroconstuct.org) by Open Worm team member Tim Busbice where the Regions, Cell Groups, Cell Mechanisms, Network and Synaptical connections are defined. After these parameters are entered and the Cell Connections and Positions are generated, the NeuroML is Exported to the files above included in the Zip file.

https://docs.google.com/drawings/pub?id=1VtsDWwGHMDdfq-rndpBJFko7zVFMmhlhr4a7OK6jQWQ&w=992&h=843&.png

## Environment for building and running the python scripts

To run, you need the python interpreter 2.6 or higher.
## Example run of the python scripts

Below, you can see the resulting work of the script:
The VB1 Neuron in Blender:

<img src=https://lh6.googleusercontent.com/-xCZ8EI0Ogqo/ThqyPTVu3aI/AAAAAAAAAC4/MaVm0NpqS90/To%252520Tim.jpg width=300> 

The NeuroML extracted from the Blender file using the Python script, imported into [NeuroConstruct](http://www.neuroconstruct.org) and visualized: 
<img src=https://lh6.googleusercontent.com/-Jigd7M0SQns/ThqyPgnZ_ZI/AAAAAAAAAC0/spVOm9tOPp0/To%252520Tim2.jpg width=300>



## What the output means

The resulting output contains NeuroML for an individual neuron. This information contains morphology for the neuron.

Example of the Python Blender extraction for neuron VB1:
    <?xml version="1.0" ?>
    <neuroml lengthUnits="micron" xmlns="http://morphml.org/neuroml/schema" xmlns:bio="http://morphml.org/biophysics/schema" xmlns:cml="http://morphml.org/channelml/schema" xmlns:meta="http://morphml.org/metadata/schema" xmlns:mml="http://morphml.org/morphml/schema" xmlns:net="http://morphml.org/networkml/schema" xmlns:schemaLocation="http://morphml.org/neuroml/schema  NeuroML.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <cells>
        <cell name="VB1">
          <meta:notes>
            C. Elegans MottoNeuron
          </meta:notes>
          <mml:segments>
            <mml:segment cable="0" id="0" name="Seg0_soma_0">
              <mml:proximal diameter="0.1" x="0.0" y="0.0" z="0.0"/>
              <mml:distal diameter="0.1" x="0.00031" y="-0.04387" z="0.01761"/>
            </mml:segment>
            <mml:segment cable="1" id="1" name="Seg0_axon_0" parent="0">
              <mml:proximal diameter="0.1" x="0.00031" y="-0.04387" z="0.01761"/>
              <mml:distal diameter="0.05" x="0.00031" y="-0.16819" z="0.07535"/>
            </mml:segment>
            <mml:segment cable="2" id="2" name="Seg2_neurite_0" parent="1">
              <mml:proximal diameter="0.05" x="0.00031" y="-0.16819" z="0.07535"/>
              <mml:distal diameter="0.05" x="-0.00681" y="-0.17804" z="0.07883"/>
            </mml:segment>
            <mml:segment cable="2" id="3" name="Seg3_neurite_0" parent="2">
              <mml:distal diameter="0.05" x="-0.0274" y="-0.17863" z="0.0791"/>
            </mml:segment>
            <mml:segment cable="2" id="4" name="Seg4_neurite_0" parent="3">
              <mml:distal diameter="0.05" x="-0.11452" y="-0.17703" z="0.0805"/>
            </mml:segment>
            <mml:segment cable="3" id="5" name="Seg5_neurite_0" parent="4">
              <mml:proximal diameter="0.05" x="-0.11452" y="-0.17703" z="0.0805"/>
              <mml:distal diameter="0.05" x="-0.12203" y="-0.18515" z="0.0834"/>
            </mml:segment>
            <mml:segment cable="3" id="6" name="Seg6_neurite_0" parent="5">
              <mml:distal diameter="0.05" x="-0.11586" y="-0.33193" z="0.13948"/>
            </mml:segment>
            <mml:segment cable="3" id="7" name="Seg7_neurite_0" parent="6">
              <mml:distal diameter="0.05" x="-0.11505" y="-0.36527" z="0.15316"/>
            </mml:segment>
            <mml:segment cable="4" id="8" name="Seg8_neurite_0" parent="4">
              <mml:proximal diameter="0.05" x="-0.11452" y="-0.17703" z="0.0805"/>
              <mml:distal diameter="0.05" x="-0.12256" y="-0.16951" z="0.07787"/>
            </mml:segment>
            <mml:segment cable="4" id="9" name="Seg9_neurite_0" parent="8">
              <mml:distal diameter="0.05" x="-0.1298" y="0.03586" z="-0.0201"/>
            </mml:segment>
            <mml:segment cable="4" id="10" name="Seg10_neurite_0" parent="9">
              <mml:distal diameter="0.05" x="-0.03126" y="0.19183" z="-0.09744"/>
            </mml:segment>
            <mml:segment cable="4" id="11" name="Seg11_neurite_0" parent="10">
              <mml:distal diameter="0.05" x="0.00416" y="0.39351" z="-0.20601"/>
            </mml:segment>
            <mml:segment cable="4" id="12" name="Seg12_neurite_0" parent="11">
              <mml:distal diameter="0.05" x="0.0044" y="1.34158" z="-0.79874"/>
            </mml:segment>
            <mml:segment cable="4" id="13" name="Seg13_neurite_0" parent="12">
              <mml:distal diameter="0.05" x="0.0044" y="1.55119" z="-0.91769"/>
            </mml:segment>
            <mml:segment cable="4" id="14" name="Seg14_neurite_0" parent="13">
              <mml:distal diameter="0.05" x="0.0044" y="3.42393" z="-2.01916"/>
            </mml:segment>
            <mml:segment cable="4" id="15" name="Seg15_neurite_0" parent="14">
              <mml:distal diameter="0.05" x="0.0044" y="3.63231" z="-2.10908"/>
            </mml:segment>
            <mml:segment cable="4" id="16" name="Seg16_neurite_0" parent="15">
              <mml:distal diameter="0.05" x="0.0044" y="4.82191" z="-2.61275"/>
            </mml:segment>
            <mml:segment cable="4" id="17" name="Seg17_neurite_0" parent="16">
              <mml:distal diameter="0.05" x="0.0044" y="5.55257" z="-2.82491"/>
            </mml:segment>
            <mml:segment cable="4" id="18" name="Seg18_neurite_0" parent="17">
              <mml:distal diameter="0.05" x="0.0044" y="6.24119" z="-2.93782"/>
            </mml:segment>
            <mml:segment cable="4" id="19" name="Seg19_neurite_0" parent="18">
              <mml:distal diameter="0.05" x="0.0044" y="7.01341" z="-2.99651"/>
            </mml:segment>
            <mml:segment cable="4" id="20" name="Seg20_neurite_0" parent="19">
              <mml:distal diameter="0.05" x="0.0044" y="8.30874" z="-2.92325"/>
            </mml:segment>
            <mml:segment cable="4" id="21" name="Seg21_neurite_0" parent="20">
              <mml:distal diameter="0.05" x="0.0044" y="8.56444" z="-2.85485"/>
            </mml:segment>
            <mml:segment cable="4" id="22" name="Seg22_neurite_0" parent="21">
              <mml:distal diameter="0.05" x="0.0044" y="10.36256" z="-2.19702"/>
            </mml:segment>
            <mml:segment cable="4" id="23" name="Seg23_neurite_0" parent="22">
              <mml:distal diameter="0.05" x="0.0044" y="10.93472" z="-1.90983"/>
            </mml:segment>
            <mml:segment cable="4" id="24" name="Seg24_neurite_0" parent="23">
              <mml:distal diameter="0.05" x="0.0044" y="11.04581" z="-1.85751"/>
            </mml:segment>
            <mml:segment cable="5" id="25" name="Seg25_neurite_0" parent="1">
              <mml:proximal diameter="0.05" x="0.00031" y="-0.16819" z="0.07535"/>
              <mml:distal diameter="0.05" x="0.00095" y="-0.18788" z="0.08231"/>
            </mml:segment>
            <mml:segment cable="5" id="26" name="Seg26_neurite_0" parent="25">
              <mml:distal diameter="0.05" x="0.00429" y="-0.4257" z="0.17479"/>
            </mml:segment>
            <mml:segment cable="5" id="27" name="Seg27_neurite_0" parent="26">
              <mml:distal diameter="0.05" x="-0.01667" y="-1.0211" z="0.40374"/>
            </mml:segment>
            <mml:segment cable="5" id="28" name="Seg28_neurite_0" parent="27">
              <mml:distal diameter="0.05" x="-0.01635" y="-1.19306" z="0.7195"/>
            </mml:segment>
            <mml:segment cable="5" id="29" name="Seg29_neurite_0" parent="28">
              <mml:distal diameter="0.05" x="-0.0004" y="-1.21999" z="0.78454"/>
            </mml:segment>
            <mml:segment cable="5" id="30" name="Seg30_neurite_0" parent="29">
              <mml:distal diameter="0.05" x="0.09264" y="-1.228" z="0.85174"/>
            </mml:segment>
            <mml:segment cable="5" id="31" name="Seg31_neurite_0" parent="30">
              <mml:distal diameter="0.05" x="0.18813" y="-1.24364" z="0.92355"/>
            </mml:segment>
            <mml:segment cable="5" id="32" name="Seg32_neurite_0" parent="31">
              <mml:distal diameter="0.05" x="0.25416" y="-1.26708" z="1.03275"/>
            </mml:segment>
            <mml:segment cable="5" id="33" name="Seg33_neurite_0" parent="32">
              <mml:distal diameter="0.05" x="0.27574" y="-1.29357" z="1.15811"/>
            </mml:segment>
          </mml:segments>
          <mml:cables>
            <mml:cable id="0" name="Soma">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                soma_group
              </meta:group>
            </mml:cable>
            <mml:cable id="1" name="Axon">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                axon_group
              </meta:group>
            </mml:cable>
            <mml:cable id="2" name="Neurite0">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                neurite_group
              </meta:group>
            </mml:cable>
            <mml:cable id="3" name="Neurite1">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                neurite_group
              </meta:group>
            </mml:cable>
            <mml:cable id="4" name="Neurite2">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                neurite_group
              </meta:group>
            </mml:cable>
            <mml:cable id="5" name="Neurite3">
              <meta:group>
                all
              </meta:group>
              <meta:group>
                neurite_group
              </meta:group>
            </mml:cable>
          </mml:cables>
        </cell>
      </cells>
    </neuroml>

Interested to participate?  Check out our [Getting Started page](http://www.openworm.org/index.html#/getstarted) and our [Contact page](http://www.openworm.org/index.html#/contacts).