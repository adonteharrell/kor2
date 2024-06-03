#!/bin/bash
IP_ADDRESS=$(ip addr show enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
sudo sh /home/korcese/restartkor.sh
firefox "$IP_ADDRESS:9511"
