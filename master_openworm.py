import errno
import matplotlib

matplotlib.use("Agg")
import shutil
from subprocess import Popen, PIPE, check_output, STDOUT
import os
import shlex
import sys
import time
import glob
import math

print("*****************************")
print("  OpenWorm Master Script")
print("*****************************")
print("")
print("This script attempts to run a full pass through the OpenWorm software stack.")
print(
    "This depends on several other repositories being loaded to work and presumes it is running in a preloaded Docker instance."
)
print("It will report out where steps are missing.")
print("Eventually all the steps will be filled in.")
print("")


print("****************************")
print("  Step 1: Run c302 + Sibernetic in the same loop.")
print("****************************")

OW_OUT_DIR = os.environ["OW_OUT_DIR"]


def execute_with_realtime_output(command, directory, env=None):
    p = None
    try:
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        print(">> Executing command: %s" % command)
        print(">> --------------------------------------------------------------")
        p = Popen(
            shlex.split(command), stdout=PIPE, stderr=STDOUT, cwd=directory, env=env
        )
        with p.stdout:
            for line in iter(p.stdout.readline, b""):
                print(">>  %s" % line.decode("utf-8"), end="")
        p.wait()  # wait for the subprocess to exit
    except KeyboardInterrupt as e:
        print("Caught CTRL+C")
        if p:
            p.kill()
        raise e
    print(">> --------------------------------------------------------------")
    print(">> Command exited with %i: %s" % (p.returncode, command))
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n")

    if p.returncode != 0:
        print("Exiting as the last command failed")
        exit(p.returncode)


sys.path.append(os.environ["C302_HOME"])

try:
    os.system("echo Granting permissions for xhost && xhost +")
except Exception:
    print("Unexpected error: %s" % sys.exc_info()[0])

OW_OUT_DIR = os.environ["OW_OUT_DIR"]


try:
    if os.access(OW_OUT_DIR, os.W_OK) is not True:
        os.system(
            "sudo chown -R %s:%s %s"
            % (os.environ["USER"], os.environ["USER"], OW_OUT_DIR)
        )
except Exception:
    print("Unexpected error: %s" % sys.exc_info()[0])
    raise

# Default is 15 ms of simulation time.
sim_duration = 15.0
if "DURATION" in os.environ:
    sim_duration = float(os.environ["DURATION"])

noc302 = False
configuration = "worm_crawl_half_resolution"
if "CONFIGURATION" in os.environ:
    configuration = os.environ["CONFIGURATION"]
    noc302 = "worm" not in configuration

PARAMETERS = {
    "duration": sim_duration,
    "dt": 0.005,
    "dtNrn": 0.05,
    "logstep": 100,
    "reference": "FW",
    "c302params": "C2",
    "verbose": False,
    "device": "CPU",
    "configuration": configuration,
    "noc302": noc302,
    "datareader": "UpdatedSpreadsheetDataReader2",
    "outDir": OW_OUT_DIR,
}

my_env = os.environ.copy()
DISPLAY = ":44"
my_env["DISPLAY"] = DISPLAY

# Xvfb or X virtual framebuffer is a display server implementing the X11 display server protocol.
# In contrast to other display servers, Xvfb performs all graphical operations in virtual memory without showing any screen output.
os.system(
    "echo Starting xvfb && Xvfb %s -listen tcp -ac -screen 0 1920x1080x24+32 &"
    % DISPLAY
)  # TODO: terminate xvfb after recording

try:
    print("Starting Sibernetic simulation with parameters:")
    for p in PARAMETERS:
        print("  %s: %s" % (p, PARAMETERS[p]))

    command = """python3 sibernetic_c302.py
                -duration %s
                -dt %s
                -dtNrn %s
                -logstep %s
                -device=%s
                -configuration %s
                -reference %s
                -c302params %s
                -datareader %s
                -outDir %s""" % (
        PARAMETERS["duration"],
        PARAMETERS["dt"],
        PARAMETERS["dtNrn"],
        PARAMETERS["logstep"],
        PARAMETERS["device"],
        PARAMETERS["configuration"],
        PARAMETERS["reference"],
        PARAMETERS["c302params"],
        PARAMETERS["datareader"],
        "simulations",
    )
    # PARAMETERS['outDir'])

    if noc302:
        command += " -noc302"

    execute_with_realtime_output(command, os.environ["SIBERNETIC_HOME"], env=my_env)

except KeyboardInterrupt:
    pass

sibernetic_sim_dir = "%s/simulations" % os.environ["SIBERNETIC_HOME"]

all_subdirs = []
for dirpath, dirnames, filenames in os.walk(sibernetic_sim_dir):
    for directory in dirnames:
        if directory.startswith(
            "%s_%s" % (PARAMETERS["c302params"], PARAMETERS["reference"])
        ):
            all_subdirs.append(os.path.join(dirpath, directory))
        if directory.startswith("Sibernetic"):
            all_subdirs.append(os.path.join(dirpath, directory))

latest_subdir = max(all_subdirs, key=os.path.getmtime)
print("\n========================================================================\n")
print("Finished main simulation, data saved in: %s" % latest_subdir)
execute_with_realtime_output(
    "ls -alt %s" % latest_subdir, os.environ["SIBERNETIC_HOME"], env=my_env
)

try:
    os.mkdir("%s/output" % OW_OUT_DIR)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

new_sim_out = "%s/output/%s" % (OW_OUT_DIR, os.path.split(latest_subdir)[-1])
try:
    os.mkdir(new_sim_out)
except OSError as e:
    if e.errno != errno.EEXIST:
        raise


# Copy PNGs, created during the Sibernetic simulation, in a separate child-directory to find them more easily
figures = glob.glob("%s/*.png" % latest_subdir)
for figure in figures:
    print("Moving %s to %s" % (figure, new_sim_out))
    shutil.move(figure, new_sim_out)

# Copy reports etc.
reports = glob.glob("%s/report*" % latest_subdir)
for report in reports:
    print("Moving %s to %s" % (report, new_sim_out))
    shutil.move(report, new_sim_out)

# Copy position files etc.
txt_files = glob.glob("%s/*.txt" % latest_subdir)
for txt_file in txt_files:
    print("Moving %s to %s" % (txt_file, new_sim_out))
    shutil.move(txt_file, new_sim_out)
dat_files = glob.glob("%s/*.dat" % latest_subdir)
for dat_file in dat_files:
    print("Moving %s to %s" % (dat_file, new_sim_out))
    shutil.move(dat_file, new_sim_out)

# Copy WCON file(s)
wcons = glob.glob("%s/*.wcon" % latest_subdir)
for wcon in wcons:
    print("Moving %s to %s" % (wcon, new_sim_out))
    shutil.move(wcon, new_sim_out)

time.sleep(2)

# Rerun and record simulation
execute_with_realtime_output(
    "ls -alt /tmp/.X11-unix", os.environ["SIBERNETIC_HOME"], env=my_env
)
os.system("export DISPLAY=%s" % DISPLAY)
execute_with_realtime_output(
    "ls -alt /tmp/.X11-unix", os.environ["SIBERNETIC_HOME"], env=my_env
)
sibernetic_movie_name = "%s.mp4" % os.path.split(latest_subdir)[-1]
command = (
    'tmux new-session -d -P -s SiberneticRecording "DISPLAY=%s ffmpeg -r 30 -f x11grab -draw_mouse 0 -s 1920x1080 -i %s -filter:v "crop=1200:800:100:100" -cpu-used 0 -b:v 384k -qmin 10 -qmax 42 -maxrate 384k -bufsize 1000k -an %s/%s"'
    % (DISPLAY, DISPLAY, new_sim_out, sibernetic_movie_name)
)
execute_with_realtime_output(command, os.environ["SIBERNETIC_HOME"], env=my_env)

time.sleep(3)

execute_with_realtime_output(
    "tmux list-sessions", os.environ["SIBERNETIC_HOME"], env=my_env
)

command = "./Release/Sibernetic -f %s -l_from lpath=%s" % (
    PARAMETERS["configuration"],
    latest_subdir,
)
execute_with_realtime_output(command, os.environ["SIBERNETIC_HOME"], env=my_env)

execute_with_realtime_output(
    "tmux send-keys -t SiberneticRecording q", os.environ["SIBERNETIC_HOME"], env=my_env
)
execute_with_realtime_output(
    'tmux send-keys -t SiberneticRecording "exit" C-m',
    os.environ["SIBERNETIC_HOME"],
    env=my_env,
)

time.sleep(3)

execute_with_realtime_output(
    "ls -alt %s" % latest_subdir, os.environ["SIBERNETIC_HOME"], env=my_env
)

# Remove black frames at the beginning of the recorded video
command = (
    "ffmpeg -i %s/%s -vf blackdetect=d=0:pic_th=0.70:pix_th=0.10 -an -f null - 2>&1 | grep blackdetect"
    % (new_sim_out, sibernetic_movie_name)
)
outstr = str(check_output(command, shell=True).decode("utf-8"))
outstr = outstr.split("\n")

black_start = 0.0
black_dur = None


out = outstr[0]

black_start_pos = out.find("black_start:")
black_end_pos = out.find("black_end:")
black_dur_pos = out.find("black_duration:")
if black_start_pos != -1:
    black_start = float(out[black_start_pos + len("black_start:") : black_end_pos])
    black_dur = float(out[black_dur_pos + len("black_duration:") :])

if black_start == 0.0 and black_dur:
    black_dur = math.ceil(black_dur)
    command = "ffmpeg -ss 00:00:0%s -i %s/%s -c copy -avoid_negative_ts 1 %s/cut_%s" % (
        black_dur,
        new_sim_out,
        sibernetic_movie_name,
        new_sim_out,
        sibernetic_movie_name,
    )
    if black_dur > 9:
        command = (
            "ffmpeg -ss 00:00:%s -i %s/%s -c copy -avoid_negative_ts 1 %s/cut_%s"
            % (
                black_dur,
                new_sim_out,
                sibernetic_movie_name,
                new_sim_out,
                sibernetic_movie_name,
            )
        )
    os.system(command)

# SPEED-UP
try:
    os.mkdir("tmp")
except OSError as e:
    if e.errno != errno.EEXIST:
        raise

os.system(
    'ffmpeg -ss 1 -i %s/cut_%s -vf "select=gt(scene\,0.1)" -vsync vfr -vf fps=fps=1/1 %s'
    % (new_sim_out, sibernetic_movie_name, "tmp/out%06d.jpg")
)
os.system(
    "ffmpeg -r 100 -i %s -r 100 -vb 60M %s/speeded_%s"
    % ("tmp/out%06d.jpg", new_sim_out, sibernetic_movie_name)
)

os.system("rm -r tmp/*")


print("****************************")
print("  Step 2: Run movement analysis")
print("****************************")
print("Not yet implemented.")
print(
    "Note however the following WCON files have been generated into %s during the simulation: %s"
    % (new_sim_out, [w.split("/")[-1] for w in wcons])
)


print("****************************")
print(" Step 3: Report on movement analysis fit to real worm videos")
print("****************************")
print("Not yet implemented.")
