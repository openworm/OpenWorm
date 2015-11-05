print("****************************")
print("OpenWorm Master Script v.0.1")
print("****************************")
print("")
print("This script attempts to run a full pass through the OpenWorm scientific libraries.")
print("This depends on several other repositories being loaded to work and presumes it is running in a preloaded docker instance.")
print("It will report out where steps are missing.")
print("Eventually all the steps will be filled in.")
print("")

print("****************************")
print("Step 1: Rebuild c302 from the latest PyOpenWorm")
print("****************************")
print("not yet implemented.")

print("****************************")
print("Step 2: Execute the latest c302 simulation")
print("****************************")
from subprocess import call
import sys, os
try:
    os.chdir("/home/openworm/CElegansNeuroML/CElegans/pythonScripts/c302")
    call(["python", "c302_Full.py"])  # To regenerate the NeuroML & LEMS files
    call(["pynml", "examples/LEMS_c302_A_Full.xml"])   # Run a simulation with jNeuroML via [pyNeuroML](http://github.com/NeuroML/pyNeuroML)
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("****************************")
print("Step 3: Feed muscle activations into Sibernetic")
print("****************************")
try:
    os.chdir("/sibernetic/src")
    call(["wget", "https://github.com/pgleeson/Smoothed-Particle-Hydrodynamics/blob/master/src/main_sim.py"])
    call(["python", "main_sim.py"])
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("****************************")
print("Step 4: Run Sibernetic")
print("****************************")
try:
    os.chdir("/sibernetic")
    call(["apt-get", "install", "make"])
    call(["make", "clean"])
    call(["make", "all"])
    call(["Xvfb", ":1", "-screen", "0", "1024x768x16"])
    call(["export", "DISPLAY=:1.0"])
    call(["./Release/Sibernetic"])
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("****************************")
print("Step 5: Extract skeleton from Sibernetic run for movement analysis")
print("****************************")
print("not yet implemented.")

print("****************************")
print("Step 6: Run movement analysis")
print("****************************")
try:
    os.chdir("/movement_validation/tests")
    call(["nosetests", "--nocapture"])
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("****************************")
print("Step 7: Report on movement analysis fit to real worm videos")
print("****************************")
print("not yet implemented.")
