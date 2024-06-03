#!/bin/bash
#Kill any korcese container
zenity --info --text="Loading Korcese..." --title="KORCESE" & ZENITY_PID=$!
sudo docker stop korcese
#Start container and move movies
sudo docker start korcese
sudo docker exec -it korcese sh convert.sh
kill $ZENITY_PID
