# The MIT License (MIT)
#
# Copyright (c) 2011, 2013 OpenWorm.
# http://openworm.org
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the MIT License
# which accompanies this distribution, and is available at
# http://opensource.org/licenses/MIT
#
# Contributors:
#      OpenWorm - http://openworm.org/people.html
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
# USE OR OTHER DEALINGS IN THE SOFTWARE.

from __future__ import with_statement
import os
###########################################################
# Updates a deployed Geppetto with latest provided the
# OpenWorm folder which contains this script is at the same
# level of all the other bundles
#
#      |---org.geppetto.*
#      |---OpenWorm
#            |---utilities
#                   |--update_sources.py (this script)
###########################################################
import urllib
import tempfile, shutil, zipfile, re, sys
from fabric.api import *
import os.path as op

urls = []

openwormpackages = ['org.geppetto.core',
'org.geppetto.model.sph',
'jLEMS',
'org.neuroml.model',
'org.geppetto.model.neuroml',
'org.geppetto.solver.sph',
'org.geppetto.simulator.sph',
'org.geppetto.simulator.jlems',
'org.geppetto.testbackend',
'org.geppetto.simulation',
'org.geppetto.frontend',
'org.geppetto'
]

geppettosourcesdir='../../'
geppettodir = geppettosourcesdir+'geppetto/'
os.environ['SERVER_HOME'] = geppettodir

#use Maven to build all the OpenWorm code bundles 
#and place the contents in the Virgo installation
for p in openwormpackages:
    dirp = op.join(geppettosourcesdir, p)
    with lcd(dirp):
          with settings(hide('everything'), warn_only=True):
             print '*********************************************************'
             print 'UPDATING ' + dirp
             pull_result= local('git pull',capture=True)
             print pull_result 
             if 'Already up-to-date' not in pull_result:
                print '*********************************************************'
                print 'BUILDING ' + dirp
                print '*********************************************************'
                print local('$MAVEN_HOME/bin/mvn install', capture=True)
                print local('cp target/classes/lib/* $SERVER_HOME/repository/usr/', capture=True)
                print local('cp target/* $SERVER_HOME/repository/usr/', capture=True)


print 'Geppetto is now updated to the latest version on master'
