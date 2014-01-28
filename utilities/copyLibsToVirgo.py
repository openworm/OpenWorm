import os
import os.path
import shutil
import fnmatch

git_path = '/Users/matteocantarelli/Documents/Development/GeppettoDev'
list_of_dirs_to_copy = [ git_path + '/org.geppetto.core/target/classes/lib', 
git_path + '/org.geppetto.frontend/target/classes/lib',
git_path + '/org.geppetto.model.sph/target/classes/lib',
git_path + '/org.geppetto.simulation/target/classes/lib',
git_path + '/org.geppetto.simulator.sph/target/classes/lib',
git_path + '/org.geppetto.model.neuroml/target/classes/lib',
git_path + '/org.geppetto.simulator.jlems/target/classes/lib',
git_path + '/org.geppetto.solver.sph/target/classes/lib']

excluded_subdirs = ['subdir-to-exclude', 'another-subdir-to-exclude']
dest_dir = '/usr/local/virgo-tomcat-server-3.6.2.RELEASE/repository/usr'
files_patterns = ['*.jar', '*.libd']

for root_path in list_of_dirs_to_copy:
	print root_path
	for root, dirs, files in os.walk(root_path): # recurse walking
		for dir in excluded_subdirs:
			if dir in dirs:
				dirs.remove(dir) # remove the dir from the subdirs to visit
		if not os.path.exists(dest_dir):
			os.makedirs(dest_dir) # create the dir if not exists
		for pattern in files_patterns:
			for thefile in fnmatch.filter(files, pattern): # filter the files to copy
				print thefile
				shutil.copy2(os.path.join(root, thefile), dest_dir) #copy file
