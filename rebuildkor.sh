#!/bin/bash
#Destroy any previous instance
podman rm korcese
podman rmi korcese
#Build korcese environment
docker-compose up -d 
#Start container and move movies
podman exec -it korcese sh convert.sh 
