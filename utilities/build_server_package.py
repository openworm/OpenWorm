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
#########################################
# Downloads a Virgo server and the OpenWorm
# bundles and creates a zip file that contains
# a configured Virgo server
# by: Stephen Larson (stephen@openworm.org)
#
# To use:
# * Make sure Maven (http://maven.apache.org) is installed
# * Make sure Fabric is installed:
#   http://docs.fabfile.org/en/1.5/installation.html
# * Set JAVA_HOME and MAVEN_HOME directories below:
os.environ['JAVA_HOME'] = '/usr'
os.environ['MAVEN_HOME'] = '/usr'
#######################################
import urllib
import tempfile, shutil, zipfile, re, sys
from fabric.api import *
import os.path as op

#check to make sure Maven is pointed to appropriately
try:
   with open(op.join(os.environ['MAVEN_HOME'], 'bin/mvn')) as f: pass
except IOError as e:
   sys.exit("Can't find mvn under " + os.environ['MAVEN_HOME'] + "-- is MAVEN_HOME set appropriately?")
   
virgo_version = "3.6.2.RELEASE"

urls = ["http://www.eclipse.org/downloads/download.php?file=/virgo/release/VP/%s/virgo-tomcat-server-%s.zip&r=1"%(virgo_version, virgo_version),
"https://github.com/LEMS/jLEMS/archive/api.zip",
"https://github.com/NeuroML/org.neuroml.model.injectingplugin/archive/master.zip",
"https://github.com/NeuroML/org.neuroml.model/archive/master.zip"
]

openwormpackages = ['org.geppetto.core',
'org.geppetto.model.sph',
'org.geppetto.model.neuroml',
'org.geppetto.solver.sph',
'org.geppetto.simulator.sph',
'org.geppetto.simulator.jlems',
'org.geppetto.testbackend',
'org.geppetto.simulation',
'org.geppetto.frontend',
'org.geppetto']

for p in openwormpackages:
    urls = urls + ['https://github.com/openworm/' + p + '/archive/master.zip']
    
print urls

tempdir = tempfile.mkdtemp()

#download and unpack all packages into a temp directory
for u in urls:
    print "Downloading: %s and unzipping into %s..."%(u,tempdir)
    (zFile, x) = urllib.urlretrieve(u)
    vz = zipfile.ZipFile(zFile)
    vz.extractall(tempdir)
    os.remove(zFile)
    
#make an openworm directory and move the contents of virgo into it
#so the final package has a nice name
with lcd(tempdir):
    print local('mkdir -p package/geppetto', capture=True)
    print local("mv virgo-tomcat-server-%s/* package/geppetto/"%(virgo_version), capture=True)
    print local("rm -rf virgo-tomcat-server-%s "%(virgo_version), capture=True)

#set server home in temp directory
server_home = op.join(tempdir, 'package/geppetto')
os.environ['SERVER_HOME'] = server_home

#use Maven to build all the OpenWorm code bundles 
#and place the contents in the Virgo installation
openwormpackages = ['jLems','org.neuroml.model.injectingplugin','org.neuroml.model']+openwormpackages
for p in openwormpackages:
    with lcd(tempdir):
        if(p=='jLems'):
            print local('mv %s-api %s'%(p, p), capture=True) #hack, assumption that all bundles come from master doesn't stand
        else:
            print local('mv %s-master %s'%(p, p), capture=True)
    dirp = op.join(tempdir, p)
    print '**************************'
    print 'BUILDING ' + dirp
    print '**************************'
    with lcd(dirp):
        with settings(hide('everything'), warn_only=True):
            print local('$MAVEN_HOME/bin/mvn install', capture=True)
            print local('cp target/classes/lib/* $SERVER_HOME/repository/usr/', capture=True)
            print local('cp target/* $SERVER_HOME/repository/usr/', capture=True)

#put the .plan file in the pickup folder      
with lcd(op.join(tempdir, 'org.geppetto')):
    print local('cp geppetto.plan $SERVER_HOME/pickup/', capture=True)
    print local('cp INSTALL $SERVER_HOME/', capture=True)
    print local('cp LICENSE $SERVER_HOME/', capture=True)

#fix the properties file REMOVED not needed anymore


#set permissions on the bin directory
#these do carry over into the archive
with lcd(server_home):
    print local('chmod -R +x ./bin', capture=True)
    
#zip up the contents of the virgo directory for distribution
archive_name = os.path.expanduser(os.path.join('~', 'geppetto-snapshot'))
root_dir = os.path.expanduser(os.path.join(tempdir, 'package'))
snapshot = shutil.make_archive(archive_name, 'zip', root_dir)

#delete the temp directory

print 'Your snapshot is ready: ' + snapshot
