print("****************************")
print("OpenWorm Master Script v.0.1")
print("****************************")
print("")
print("This script attempts to run a full pass through the OpenWorm scientific libraries.")
print("This depends on several other repositories being loaded to work")
print("It will report out where steps are missing.")
print("Eventually all the steps will be filled in.")
print("")

print("Step 1: Rebuild c302 from the latest PyOpenWorm")
print("not yet implemented.")

print("Step 2: Execute the latest c302 simulation")
from subprocess import call
import sys
try:
    call(["cd", "../CElegansNeuroML/CElegans/pythonScripts/c302"])
    call(["python", "c302_Full.py"])  # To regenerate the NeuroML & LEMS files
    call(["pynml", "examples/LEMS_c302_A_Full.xml"])   # Run a simulation with jNeuroML via [pyNeuroML](http://github.com/NeuroML/pyNeuroML)
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("Step 3: Feed muscle activations into Sibernetic")
print("not yet implemented.")

print("Step 4: Run Sibernetic")
try:
    call(["../../sibernetic/Release/Sibernetic"])
except:
    print "Unexpected error:", sys.exc_info()[0]
    raise

print("Step 5: Extract skeleton from Sibernetic run for movement analysis")
print("not yet implemented.")

print("Step 6: Run movement analysis")
print("not yet implemented.")

print("Step 7: Report on movement analysis fit to real worm videos")
print("not yet implemented.")
