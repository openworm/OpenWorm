""" 
worm2hive.py
Simple script for turning connectome tables into HivePlot graphs.

Note that the tables were extracted manually from the connectivity spreadsheet
of the c. elegans and should accompany this script.

Author: Pedro Tabacof (tabacof at gmail dot com)
License: Public Domain
"""

# -*- coding: utf-8 -*- 

import csv

worm = open("worm.txt", "w") # HivePlot graph file

with open('neurons.csv', 'r') as csvfile: # Neuron table
    reader = csv.reader(csvfile, delimiter=';', quotechar='|')
    for row in reader:
        neurontype = ""
        # Detects neuron function
        if "sensory" in row[1].lower():
            neurontype += "ntype=sensory "
        if "motor" in row[1].lower():
            neurontype += "ntype=motor "    
        if "interneuron" in row[1].lower():
            neurontype += "ntype=interneuron "
        if len(neurontype) == 0:
            neurontype = "ntype=unknown"
        
        if len(row[0]) > 0: # Only saves valid neuron names
            worm.write(row[0] + " [" + neurontype + "]\n")

worm.write('\n')

with open('connectome.csv', 'r') as csvfile: # Connectome table
    reader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in reader:
        worm.write(row[0] + " -> " + row[1] + " [synapse=" + row[2] + " connections=" + row[3] + " neurotransmitter=" + row[4] + "]\n")
        
worm.close()

print("Hive Plot graph stored in worm.txt - use jhive to open it and see the connectome")
