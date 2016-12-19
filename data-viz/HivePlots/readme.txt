This folder contains the following files:

1) connectome.csv - connectivity table from the "Connectome" tab of the condensed
connectivity spreadsheet

2) neurons.csv - neuron table condensed from the "Single Neurons" tab of the regular
connectivity spreadsheet

3) simpleatlas.csv - second connectivity table of the "Neuronal Connectivity" tab of the
regular connectivity spreadsheet

4) wormatlas.csv - first connectivity table of the Neuronal Connectivity" tab of the
regular connectivity spreadsheet

5) worm2hive.py - Python script that converts the connectivity info (specifically from
connectome.csv and neurons.csv) into the jhive format.

6) worm2nx.py - A modification of worm2hive.py that explores the connectome.csv and 
neurons.csv data structure using NetworkX and Matplotlib.  An iPython notebook was created
to capture the development of this here: http://nbviewer.ipython.org/5486105

6) *.png - some Hive Plots made with jhive and edited with MS Paint.

To run the script just go to this folder on the command line (on any OS with Python 2.7)
and type "python worm2hive.py". The result will be stored on worms.txt, so now with jhive
you can open it and make your own hive plots.

You can get JHive here: http://www.hiveplot.net/distro/jhive-0.0.16.zip

To color gap junctions, just write this on the rules and apply: e(synapse=GapJunction)
[thickness=1;rgb=2;opacity=50].

To separate nodes into neuron types, just choose axis x:$ntype and type: a1:
'x'=='interneuron' a2: 'x'=='motor' a3: 'x'=='sensory'

You can do much more than this, but you will have to learn to work with jhive and take a
look at worms.txt to see what properties can be used for plotting.

=Examples=

Show only chemical synapses

clear
[show=yes]
e(synapse=Send) [rgb=4;opacity=40]

Show only gap junctions

clear
[show=yes]
e(synapse=GapJunction) [rgb=2;opacity=40]

Show only edges with connections > 10

clear
[show=yes]
e(connections=10) [rgb=1;opacity=40;thickness=10]
e(connections=11) [rgb=1;opacity=40;thickness=10]
e(connections=12) [rgb=1;opacity=40;thickness=10]
e(connections=13) [rgb=1;opacity=40;thickness=10]
e(connections=14) [rgb=1;opacity=40;thickness=10]
e(connections=15) [rgb=1;opacity=40;thickness=10]
e(connections=16) [rgb=1;opacity=40;thickness=10]
e(connections=17) [rgb=1;opacity=40;thickness=10]
e(connections=18) [rgb=1;opacity=40;thickness=10]
e(connections=19) [rgb=1;opacity=40;thickness=10]
e(connections=20) [rgb=1;opacity=40;thickness=10]
e(connections=21) [rgb=1;opacity=40;thickness=10]
e(connections=23) [rgb=1;opacity=40;thickness=10]
e(connections=24) [rgb=1;opacity=40;thickness=10]
e(connections=25) [rgb=1;opacity=40;thickness=10]
e(connections=26) [rgb=1;opacity=40;thickness=10]
e(connections=27) [rgb=1;opacity=40;thickness=10]
e(connections=30) [rgb=1;opacity=40;thickness=10]
e(connections=35) [rgb=1;opacity=40;thickness=10]
e(connections=37) [rgb=1;opacity=40;thickness=10]

Show edges with connections >10 as thin, >15 as thicker, >20 as thickest
clear
[show=yes]
e(connections=10) [rgb=6;opacity=30;thickness=5]
e(connections=11) [rgb=6;opacity=30;thickness=5]
e(connections=12) [rgb=6;opacity=30;thickness=5]
e(connections=13) [rgb=6;opacity=30;thickness=5]
e(connections=14) [rgb=6;opacity=30;thickness=5]
e(connections=15) [rgb=6;opacity=30;thickness=5]
e(connections=16) [rgb=1;opacity=40;thickness=8]
e(connections=17) [rgb=1;opacity=40;thickness=8]
e(connections=18) [rgb=1;opacity=40;thickness=8]
e(connections=19) [rgb=1;opacity=40;thickness=8]
e(connections=20) [rgb=5;opacity=70;thickness=10]
e(connections=21) [rgb=5;opacity=70;thickness=10]
e(connections=23) [rgb=5;opacity=70;thickness=10]
e(connections=24) [rgb=5;opacity=70;thickness=10]
e(connections=25) [rgb=5;opacity=70;thickness=10]
e(connections=26) [rgb=5;opacity=70;thickness=10]
e(connections=27) [rgb=5;opacity=70;thickness=10]
e(connections=30) [rgb=5;opacity=70;thickness=10]
e(connections=35) [rgb=5;opacity=70;thickness=10]
e(connections=37) [rgb=5;opacity=70;thickness=10]
