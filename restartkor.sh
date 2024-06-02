#!/bin/bash
#Kill any korcese container
podman stop korcese
#Start container and move movies
podman start korcese ; podman exec -it korcese sh convert.sh 
