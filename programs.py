#!/usr/bin/env python3

# see https://askubuntu.com/questions/728157/how-to-get-the-list-of-running-gui-applications-in-the-unity-launcher

import subprocess
import sys

try:
    listed = sys.argv[1]
except IndexError:
    listed = []

get = lambda cmd: subprocess.check_output(cmd).decode("utf-8").strip()

def check_wtype(w_id):
    # check the type of window; only list "NORMAL" windows
    return "_NET_WM_WINDOW_TYPE_NORMAL" in get(["xprop", "-id", w_id])

def get_process(w_id):
    # get the name of the process, owning the window
    proc = get(["ps", "-p", w_id, "-o", "comm="])
    proc = "gnome-terminal" if "gnome-terminal" in proc else proc
    return proc

wlist = [l.split() for l in subprocess.check_output(["wmctrl", "-lp"])\
         .decode("utf-8").splitlines()]

validprocs = set([get_process(w[2]) for w in wlist if check_wtype(w[0]) == True])

if listed == "-list":
    for p in sorted(validprocs):
        print(p)
else:
    print(validprocs)
