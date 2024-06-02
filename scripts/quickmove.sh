#!/bin/bash

find /windows/Videos -type f -name "*.mp4" -mmin -120 -exec cp -u -v {} /storage/webserver/movies \;

sh /movies/convert.sh

