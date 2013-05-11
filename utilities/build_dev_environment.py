from __future__ import with_statement
try:
    import os
    import subprocess
    import urllib
    import zipfile
    import sys
    from fabric.api import *
    import os.path as op
    import argparse
except ImportError as exc:
    sys.exit("Error: failed to import required module({})".format(exc))


#########################################
# Downloads a Virgo server and the OpenWorm
# bundles, compiles using Maven & deploys in Virgo
# by: Stephen Larson (stephen@openworm.org)
#     Padraig Gleeson (p.gleeson@gmail.com)
#     Mariusz Sasinski (m.sasinski@stormbyte.com)
#
# To use:
# * Make sure Maven (http://maven.apache.org) is installed
# * Make sure Fabric is installed:
#   http://docs.fabfile.org/en/1.5/installation.html

virgo_download = "http://www.eclipse.org/downloads/download.php?file=/virgo/release/VP/%s/virgo-tomcat-server-%s.zip&r=1"


parser = argparse.ArgumentParser(description='Download Virgo server and OpenWorm bundles, compiles using Maven and deploys in Virgo.')
parser.add_argument('--clone-method', help='Select method to clone github repository (SSH,HTTP,Git-ReadOnly). Default=SSH', required=False, default="SSH")
parser.add_argument('--virgo-version', help="Virgo Version",required=False,default="3.6.0.RELEASE")
parser.add_argument('--virgo-download-location', help="Download location for Virgo Server. Must be in quotes",required=False)
parser.add_argument('--repository-dir', help="Directory for OpenWorm bundles and Virgo server. Relative to your home dir.",required=False,default="openworm_dev")
parser.add_argument('--skip-jdk-check',help="Skip OpenJDK check and allow script to continue. (not recommended). Usage: --skip-jdk-check=1",required=False,default=0)
args = vars(parser.parse_args())

virgo_version = args['virgo_version']
if args['virgo_download_location']:
    virgo_zip = args['virgo_download_location']
else:
    virgo_zip = virgo_download%(virgo_version,virgo_version)

# Set the preferred method for cloning from GitHub
github_pref = args['clone_method']

# Set the location to create the development environment
repository_dir = op.join(os.environ['HOME'], args['repository_dir'])

#check if JAVA_HOME is set
if os.environ.get("JAVA_HOME") == None:
   print "Warning: JAVA_HOME not set."

#if MAVEN home is set use it during execution, otherwise try using mvn from PATH
if os.environ.get("MAVEN_HOME") == None:
    print "Warning: MAVEN_HOME not set"
    maven_exec = "mvn"
else:
    maven_exec = os.environ.get("MAVEN_HOME") + "/bin/mvn"

#######################################

#Check if we have all necessary applications
try:
    cmd = subprocess.check_call([maven_exec + ' --version'],shell=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE)
except subprocess.CalledProcessError as e:
    sys.exit("Maven not found. Please make sure that Maven is installed, and MAVEN_HOME is set")
try:
    cmd = subprocess.check_call(["java -version"],shell=True, stderr=subprocess.STDOUT,stdout=subprocess.PIPE)
    if args['skip_jdk_check'] == 1:
        result = subprocess.Popen(['java -version'], stderr=subprocess.STDOUT, stdout=subprocess.PIPE, shell=True).communicate()[0]
        if result.find("OpenJDK") != -1:
            sys.exit("OpenJDK is not recommended. To use OpenJDK anyway run this script with --skip-jdk-check=1")
except subprocess.CalledProcessError as e:
    sys.exit("Java not found. Please make sure that Java is installed, and JAVA_HOME is set")
try:
    cmd = subprocess.check_call(["git --version"],shell=True,stderr=subprocess.STDOUT,stdout=subprocess.PIPE)
except subprocess.CalledProcessError as e:
    sys.exit("Please install Git")


#check to make sure Maven is pointed to appropriately

openwormpackages = ['org.geppetto.core',
'org.geppetto.samplesolver',
'org.geppetto.samplesimulator',
'org.geppetto.samplesimulation',
'org.geppetto.model.sph',
'org.geppetto.solver.sph',
'org.geppetto.simulator.sph',
'org.geppetto.simulation',
'org.geppetto.frontend',
'org.geppetto']

pre={}
pre["HTTP"]="https://github.com/openworm/"
pre["SSH"]="git@github.com:openworm/"
pre["Git-ReadOnly"]="git://github.com/openworm/"

repos = []
for p in openwormpackages:
    repos = repos + [pre[github_pref] + p + '.git']


if not op.isdir(repository_dir):
    print "Creating a new directory: " + repository_dir
    os.mkdir(repository_dir)


virgo_dir = op.join(repository_dir, "virgo-tomcat-server-"+virgo_version)
if not op.isdir(virgo_dir):
    print "Downloading: %s and unzipping into %s..."%(virgo_zip,repository_dir)
    (zFile, x) = urllib.urlretrieve(virgo_zip)
    vz = zipfile.ZipFile(zFile)
    vz.extractall(repository_dir)
    os.remove(zFile)
else:
    print "Keeping existing Virgo install in "+virgo_dir

os.environ['SERVER_HOME'] = virgo_dir

for owp in openwormpackages:
    with lcd(repository_dir):
        print
        if not op.isdir(op.join(repository_dir, owp)):
            print "Cloning repository %s into %s"%(owp, repository_dir)
            repo = pre[github_pref] + owp + '.git'
            print local('git clone %s'%repo, capture=True)
        else:
            print "Using existing repository %s in %s"%(owp, repository_dir)
            with lcd(op.join(repository_dir, owp)):
                print local('git pull', capture=True)

        with lcd(op.join(repository_dir, owp)):
            print local(maven_exec + ' install', capture=True)
            if op.isdir(op.join(repository_dir, owp+"/target/classes/lib/")):   # Probably not platform indep...
                print local('cp target/classes/lib/* $SERVER_HOME/repository/usr/', capture=True)
            print local('pwd', capture=True)

            with settings(hide('everything'), warn_only=True):
                print local('cp target/*.*ar $SERVER_HOME/repository/usr/', capture=True)


#put the .plan file in the pickup folder
with lcd(op.join(repository_dir, 'org.geppetto')):
    print local('cp owsefull.plan $SERVER_HOME/pickup/', capture=True)


#fix the properties file REMOVED, not needed anymore

#set permissions on the bin directory
#these do carry over into the archive
with lcd(virgo_dir):
    print local('chmod -R +x ./bin', capture=True)


print 'Your local development environment is ready at: ' + repository_dir
