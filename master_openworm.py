import errno
import shutil
from subprocess import Popen, PIPE, check_output
import os
import pwd
import shlex
import sys
import time
import glob
import math

import matplotlib

matplotlib.use('Agg')

print("*****************************")
print("OpenWorm Master Script v0.9.2")
print("*****************************")
print("")
print("This script attempts to run a full pass through the OpenWorm scientific libraries.")
print("This depends on several other repositories being loaded to work and presumes it is running in a preloaded Docker instance.")
print("It will report out where steps are missing.")
print("Eventually all the steps will be filled in.")
print("")

print("****************************")
print("Step 1: Rebuild c302 from the latest owmeta")
print("****************************")
print("Not yet implemented. See https://github.com/openworm/c302/issues/10")


print("****************************")
print("Step 2: Execute unit tests via the c302 simulation framework")
print("****************************")
"""
from runAndPlot import run_c302
orig_display_var = None
if os.environ.has_key('DISPLAY'):
    orig_display_var = os.environ['DISPLAY']
    del os.environ['DISPLAY'] # https://www.neuron.yale.edu/phpBB/viewtopic.php?f=6&t=1603

run_c302(DEFAULTS['reference'],
         DEFAULTS['c302params'],
         '',
         DEFAULTS['duration'],
         DEFAULTS['dt'],
         'jNeuroML_NEURON',
         data_reader=DEFAULTS['datareader'],
         save=True,
         show_plot_already=False,
         target_directory=os.path.join(os.environ['C302_HOME'], 'examples'),
         save_fig_to='tmp_images')
prev_dir = os.getcwd()
os.chdir(DEFAULTS['outDir'])
try:
    os.mkdir('c302_out')
except OSError as e:
    if e.errno != errno.EEXIST:
        raise
src_files = os.listdir(os.path.join(os.environ['C302_HOME'], 'examples', 'tmp_images'))
for file_name in src_files:
    full_file_name = os.path.join(os.environ['C302_HOME'], 'examples', 'tmp_images', file_name)
    print("COPY %s" % full_file_name)
    if (os.path.isfile(full_file_name)):
        shutil.copy2(full_file_name, 'c302_out')
shutil.rmtree(os.path.join(os.environ['C302_HOME'], 'examples', 'tmp_images'))
os.chdir(prev_dir)
if orig_display_var:
    os.environ['DISPLAY'] = orig_display_var
"""

print("****************************")
print("Step 3: Run c302 + Sibernetic in the same loop.")
print("****************************")

OW_OUT_DIR = os.environ['OW_OUT_DIR']

def execute_with_realtime_output(command, directory, env=None):
    p = None
    try:
        p = Popen(shlex.split(command),
            stdout=PIPE,
            bufsize=1,
            cwd=directory,
            env=env,
            text=True)
        with p.stdout:
            for line in iter(p.stdout.readline, ''):
                print(line, end='')
        p.wait() # wait for the subprocess to exit
    except KeyboardInterrupt as e:
        print("Caught CTRL+C")
        if p:
            p.kill()
        raise e


sys.path.append(os.environ['C302_HOME'])

OW_OUT_DIR = os.environ['OW_OUT_DIR']


try:
    if os.access(OW_OUT_DIR, os.W_OK) is not True:
        os.system('sudo chown -R %s:%s %s' % (os.environ['USER'], os.environ['USER'], OW_OUT_DIR))
except:
    print("Unexpected error: %s" % sys.exc_info()[0])
    raise

#Default is 15 ms of simulation time.
sim_duration = 15.0
if 'DURATION' in os.environ:
    sim_duration = float(os.environ['DURATION'])

DEFAULTS = {'duration': sim_duration,
            'dt': 0.005,
            'dtNrn': 0.05,
            'logstep': 100,
            'reference': 'FW',
            'c302params': 'C2',
            'verbose': False,
            'device': 'GPU',
            'configuration': 'worm_crawl_half_resolution',
            'noc302': False,
            'datareader': 'UpdatedSpreadsheetDataReader2',
            'outDir': OW_OUT_DIR}

my_env = os.environ.copy()

try:
    command = """python sibernetic_c302.py
                -duration %s
                -dt %s
                -dtNrn %s
                -logstep %s
                -device=%s
                -configuration %s
                -reference %s
                -c302params %s
                -datareader %s
                -outDir %s""" % \
                (DEFAULTS['duration'],
                DEFAULTS['dt'],
                DEFAULTS['dtNrn'],
                DEFAULTS['logstep'],
                DEFAULTS['device'],
                DEFAULTS['configuration'],
                DEFAULTS['reference'],
                DEFAULTS['c302params'],
                DEFAULTS['datareader'],
                'simulations')
                #DEFAULTS['outDir'])
    execute_with_realtime_output(command, os.environ['SIBERNETIC_HOME'], env=my_env)
except KeyboardInterrupt as e:
    pass

sibernetic_sim_dir = '%s/simulations' % os.environ['SIBERNETIC_HOME']

all_subdirs = []
for dirpath, dirnames, filenames in os.walk(sibernetic_sim_dir):
    for directory in dirnames:
        if directory.startswith('%s_%s' % (DEFAULTS['c302params'], DEFAULTS['reference'])):
            all_subdirs.append(os.path.join(dirpath, directory))

latest_subdir = max(all_subdirs, key=os.path.getmtime)


try:
    os.mkdir('%s/output' % OW_OUT_DIR)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

new_sim_out = '%s/output/%s' % (OW_OUT_DIR, os.path.split(latest_subdir)[-1])
try:
    os.mkdir(new_sim_out)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise


# Copy PNGs, created during the Sibernetic simulation, in a separate child-directory to find them more easily
figures = glob.glob('%s/*.png' % latest_subdir)
for figure in figures:
    print("Moving %s to %s"%(figure, new_sim_out))
    shutil.move(figure, new_sim_out)

# Copy reports etc.
reports = glob.glob('%s/report*' % latest_subdir)
for report in reports:
    print("Moving %s to %s"%(report, new_sim_out))
    shutil.move(report, new_sim_out)

# Copy WCON file(s)
wcons = glob.glob('%s/*.wcon' % latest_subdir)
for wcon in wcons:
    print("Moving %s to %s"%(wcon, new_sim_out))
    shutil.move(wcon, new_sim_out)


# Rerun and record simulation
sibernetic_movie_name = '%s.mp4' % os.path.split(latest_subdir)[-1]
sibernetic_movie_filename = f"{new_sim_out}/{sibernetic_movie_name}"
display = os.environ['DISPLAY']

command = f'./Release/Sibernetic -f {DEFAULTS["configuration"]} -l_from lpath={latest_subdir} -vout "{sibernetic_movie_filename}" -vcodec mpeg4'
execute_with_realtime_output(command, os.environ['SIBERNETIC_HOME'], env=my_env)

# Remove black frames at the beginning of the recorded video
#command = "ffmpeg -nostdin -i %s/%s -vf blackdetect=d=0:pic_th=0.70:pix_th=0.10 -an -f null - 2>&1 | grep blackdetect" % (new_sim_out, sibernetic_movie_name)
command = f'ffmpeg -nostdin -i "{sibernetic_movie_filename}" -vf blackdetect=d=0:pic_th=0.70:pix_th=0.10 -an -f null - 2>&1'

try:
    outstr = str(check_output(command, shell=True).decode('utf-8'))
except Exception as e:
    print(f"----------------------OUTPUT------------------------\n{e.output.decode('utf-8')}")
    raise

print(f"----------------------OUTPUT------------------------\n{outstr}")

outstr = outstr.split('\n')

black_start = 0.0
black_dur = None


out = outstr[0]

black_start_pos = out.find('black_start:')
black_end_pos = out.find('black_end:')
black_dur_pos = out.find('black_duration:')
if black_start_pos != -1:
    black_start = float(out[black_start_pos + len('black_start:') : black_end_pos])
    black_dur = float(out[black_dur_pos + len('black_duration:'):])


if black_start == 0.0 and black_dur:
    sibernetic_movie_trimmed_filename = f"{new_sim_out}/cut_{sibernetic_movie_name}"
    black_dur = int(math.ceil(black_dur))
    time = f'00:00:{black_dur:02}'
    command = f'ffmpeg -nostdin -ss {time} -i "{sibernetic_movie_filename}" -c copy -avoid_negative_ts 1 "{sibernetic_movie_trimmed_filename}"'
    os.system(command)
    os.rename(sibernetic_movie_trimmed_filename, sibernetic_movie_filename)
else:
    print('No black frames detected')

# SPEED-UP
try:
    os.mkdir('tmp')
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

temp_movie_filename = 'tmp/out%06d.jpg'
os.system(f'ffmpeg -nostdin -ss 1 -i "{sibernetic_movie_filename}" -vf "select=gt(scene\,0.1)" -vsync vfr -vf fps=fps=1/1 "{temp_movie_filename}"')
os.system(f'ffmpeg -nostdin -r 100 -i "{temp_movie_filename}" -r 100 -vb 60M "{new_sim_out}/speeded_{sibernetic_movie_name}"')

os.system('sudo rm -r tmp/*')



print("****************************")
print("Step 4: Run movement analysis")
print("****************************")
print("Not yet implemented.")
print("Note however the following WCON files have been generated into %s during the simulation: %s"%(new_sim_out, [w.split('/')[-1] for w in wcons]))


print("****************************")
print("Step 5: Report on movement analysis fit to real worm videos")
print("****************************")
print("Not yet implemented.")
