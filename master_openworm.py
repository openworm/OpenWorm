from __future__ import print_function
import errno
import matplotlib
matplotlib.use('Agg')
import shutil
from subprocess import call, Popen, PIPE, check_output
import os
import pwd
import shlex
import sys
import time
import glob
import math

print("***************************")
print("OpenWorm Master Script v0.9")
print("***************************")
print("")
print("This script attempts to run a full pass through the OpenWorm scientific libraries.")
print("This depends on several other repositories being loaded to work and presumes it is running in a preloaded Docker instance.")
print("It will report out where steps are missing.")
print("Eventually all the steps will be filled in.")
print("")

print("****************************")
print("Step 1: Rebuild c302 from the latest PyOpenWorm")
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
        p = Popen(shlex.split(command), stdout=PIPE, bufsize=1, cwd=directory, env=env)
        with p.stdout:
            for line in iter(p.stdout.readline, b''):
                print(line, end="")
        p.wait() # wait for the subprocess to exit
    except KeyboardInterrupt as e:
        print("Caught CTRL+C")
        if p:
            p.kill()
        raise e


sys.path.append(os.environ['C302_HOME'])

try:
    os.system('xhost +')
except:
    print("Unexpected error: %s" % sys.exc_info()[0])

OW_OUT_DIR = os.environ['OW_OUT_DIR']


try:
    if pwd.getpwuid(os.stat(OW_OUT_DIR).st_uid).pw_name != os.environ['USER']:
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
my_env["DISPLAY"] = ":44"

os.system('Xvfb :44 -listen tcp -ac -screen 0 1920x1080x24+32 &') # TODO: terminate xvfb after recording

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
os.system('export DISPLAY=:44')
sibernetic_movie_name = '%s.mp4' % os.path.split(latest_subdir)[-1]
os.system('tmux new-session -d -s SiberneticRecording "DISPLAY=:44 ffmpeg -r 30 -f x11grab -draw_mouse 0 -s 1920x1080 -i :44 -filter:v "crop=1200:800:100:100" -cpu-used 0 -b:v 384k -qmin 10 -qmax 42 -maxrate 384k -bufsize 1000k -an %s/%s"' % (new_sim_out, sibernetic_movie_name))

command = './Release/Sibernetic -f %s -l_from lpath=%s' % (DEFAULTS['configuration'], latest_subdir)
execute_with_realtime_output(command, os.environ['SIBERNETIC_HOME'], env=my_env)

os.system('tmux send-keys -t SiberneticRecording q')
os.system('tmux send-keys -t SiberneticRecording "exit" C-m')

time.sleep(3)

# Remove black frames at the beginning of the recorded video
command = "ffmpeg -i %s/%s -vf blackdetect=d=0:pic_th=0.70:pix_th=0.10 -an -f null - 2>&1 | grep blackdetect" % (new_sim_out, sibernetic_movie_name)
outstr = check_output(command, shell=True)
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
    black_dur = int(math.ceil(black_dur))
    command = 'ffmpeg -ss 00:00:0%s -i %s/%s -c copy -avoid_negative_ts 1 %s/cut_%s' % (black_dur, new_sim_out, sibernetic_movie_name, new_sim_out, sibernetic_movie_name)
    if black_dur > 9:
        command = 'ffmpeg -ss 00:00:%s -i %s/%s -c copy -avoid_negative_ts 1 %s/cut_%s' % (black_dur, new_sim_out, sibernetic_movie_name, new_sim_out, sibernetic_movie_name)
    os.system(command)

# SPEED-UP
try:
    os.mkdir('tmp')
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

os.system('ffmpeg -ss 1 -i %s/cut_%s -vf "select=gt(scene\,0.1)" -vsync vfr -vf fps=fps=1/1 %s' % (new_sim_out, sibernetic_movie_name, 'tmp/out%06d.jpg'))
os.system('ffmpeg -r 100 -i %s -r 100 -vb 60M %s/speeded_%s' % ('tmp/out%06d.jpg', new_sim_out, sibernetic_movie_name))

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
