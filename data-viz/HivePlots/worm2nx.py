""" 
worm2nx.py
Simple script for turning connectome tables into NetworkX graphs.

Note that the tables were extracted manually from the connectivity spreadsheet
of the c. elegans and should accompany this script.

Author: Pedro Tabacof (tabacof at gmail dot com)
        Stephen Larson (stephen@openworm.org)
License: Public Domain
"""

# -*- coding: utf-8 -*- 

import csv

import urllib2

import networkx as nx

worm = nx.DiGraph()

# Neuron table
csvfile = urllib2.urlopen('https://raw.github.com/openworm/data-viz/master/HivePlots/neurons.csv')

reader = csv.reader(csvfile, delimiter=';', quotechar='|')
for row in reader:
    neurontype = ""
    # Detects neuron function
    if "sensory" in row[1].lower():
        neurontype += "sensory"
    if "motor" in row[1].lower():
        neurontype += "motor"    
    if "interneuron" in row[1].lower():
        neurontype += "interneuron"
    if len(neurontype) == 0:
        neurontype = "unknown"
        
    if len(row[0]) > 0: # Only saves valid neuron names
        worm.add_node(row[0], ntype = neurontype)

# Connectome table
csvfile = urllib2.urlopen('https://raw.github.com/openworm/data-viz/master/HivePlots/connectome.csv')

reader = csv.reader(csvfile, delimiter=',', quotechar='|')
for row in reader:
    worm.add_edge(row[0], row[1], weight = row[3])
    worm[row[0]][row[1]]['synapse'] = row[2]
    worm[row[0]][row[1]]['neurotransmitter'] = row[4]

#get the degree of a given node for gap junction edges only
def GJ_degree(node):
    count = 0
    for item in worm.in_edges_iter(node,data=True):
        if 'GapJunction' in item[2]['synapse']:
            #count = count + int(item[2]['weight'])
            count = count + 1
    for item in worm.out_edges_iter(node,data=True):
        if 'GapJunction' in item[2]['synapse']:
            #count = count + int(item[2]['weight'])
            count = count + 1
    return count

#get the degree of a given node for chemical synapse edges only
def Syn_degree(node):
    count = 0
    for item in worm.in_edges_iter(node,data=True):
        if 'Send' in item[2]['synapse']:
            #count = count + int(item[2]['weight'])
            count = count + 1
    for item in worm.out_edges_iter(node,data=True):
        if 'Send' in item[2]['synapse']:
            #count = count + int(item[2]['weight'])
            count = count + 1
    return count

#for a given set of neuron nodes, count the total degree, 
# the degree of gap junctions only, and the degree of the 
# chemical synapse edges and store them in 3 dicts, 
# ids, ids_GJ and ids_Syn
ids = {}
ids_GJ = {}
ids_Syn = {}
for item in worm.nodes_iter(data=True):
    if item[0] in ['AVAL', 'AVAR', 'AVBL', 'AVBR', 'PVCR', 'PVCL', 'AVDR', 'AVER']:
        if 'interneuron' in item[1]['ntype']:
            ids[item[0]] = worm.degree(item[0])
            ids_GJ[item[0]] = GJ_degree(item[0])
            ids_Syn[item[0]] = Syn_degree(item[0])
            
degrees = []
for item in worm.nodes_iter(data=True):
    degrees.append(int(worm.degree(item[0])))
    
print "AVAL in edges: " + str(len(worm.in_edges('AVAL')))

import numpy as np
print "**********************"
print "Average Degree: " + str(np.mean(degrees))
print "Std. Dev Degree: " + str(np.std(degrees))

print "******DEGREES OF TOP FOUR INTERNEURONS*******"
for x in ['AVAL', 'AVAR', 'AVBL', 'AVBR']:
    print "Degree of " + x + ": " + str(worm.degree(x)) + " Z-score: " + str((worm.degree(x) - np.mean(degrees)) / np.std(degrees))

print "******DEGREES OF NEXT FOUR INTERNEURONS*******"
for x in ['PVCR', 'PVCL', 'AVDR', 'AVER']:
    print "Degree of " + x + ": " + str(worm.degree(x)) + " Z-score: " + str((worm.degree(x) - np.mean(degrees)) / np.std(degrees))

print "******DEGREE OF TOP SENSORY NEURON*******"
print "Degree of ADEL: " + str(worm.degree('ADEL')) + " Z-score: " + str((worm.degree('ADEL') - np.mean(degrees)) / np.std(degrees))
print "******DEGREE OF TOP MOTOR NEURON*******"
print "Degree of RIMR: " + str(worm.degree('RIMR')) + " Z-score: " + str((worm.degree('RIMR') - np.mean(degrees)) / np.std(degrees))

import operator

ids = sorted(ids.iteritems(), key=operator.itemgetter(1))

ids_GJ_sorted = []
ids_Syn_sorted = []
for item in ids:
    ids_GJ_sorted.append((item[0], ids_GJ[item[0]]))
    ids_Syn_sorted.append((item[0], ids_Syn[item[0]] + ids_GJ[item[0]])) #add syn to GJ so total bar height is total degree

ids_GJ = ids_GJ_sorted
ids_Syn = ids_Syn_sorted

#print ids
#print ids_GJ
#print ids_Syn

from pylab import *

pos = arange(len(ids))+1    # the bar centers on the y axis

fig = figure(figsize=(10,10))
ax = fig.add_subplot(111)

#p1 = bar(pos,[x[1] for x in ids], align='center', color='r')

p2 = bar(pos,[x[1] for x in ids_Syn], align='center')

p3 = bar(pos,[x[1] for x in ids_GJ], align='center', color='y')

xlabel('Interneurons')
ylabel('Degree')
xticks( pos, [x[0] for x in ids])
title('Interneurons by node degree')
#legend( (p1[0], p2[0], p3[0]), ('All edges', 'Synapses only', 'Gap junctions only'), loc=2)
legend( (p2[0], p3[0]), ('Synapses', 'Gap junctions'), loc=2)
setp(ax.get_xticklabels(), fontsize=12, rotation='vertical')

show()
