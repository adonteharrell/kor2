#!/bin/bash
date=$(date +%F---%r)


# Append to log file starting the time on log file. 
find /videos -type f -name "*.mp4" -exec cp -u -v {} /movies \;

# CD into movies directory to run convert script.
sh convert.sh
