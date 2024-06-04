#!/bin/bash

clear -x
time=$(date +%l:%M)
IP_ADDRESS=$(ip addr show enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
pm=$(date +%p)
movies=$(docker exec -it korcese bash ls /movies/*.mp4 | wc -l)
BOLD="\e[1;32m"
CLEAR="\e[0m"
RED="\e[1;31m"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
container_name="korcese"
container_status=$(docker inspect --format='{{.State.Running}}' "$container_name" 2>/dev/null)
if [ "$container_status" == "true" ]; then
  kor_status="${BOLDGREEN} Korcese is running. ${CLEAR}"
else
  kor_status="${RED} Korcese is not running. Run Build Korcese. ${CLEAR}"
fi

clear -x

while true
do
         echo -e " Movies: ${BOLD} $movies ${CLEAR}                        $time $pm"
         cat /home/korcese/splash
         echo -e "$kor_status"
         read -p "
         1. Build Korcese
         2. Update Korcese
         3. Connect to Network
         4. Exit
Enter Option:
" CHOICE
        case "$CHOICE" in
               1)
                       clear -x
                       sudo sh /root/kor2/buildkor.sh
                       clear -x
                       ;;
               2)
                       clear -x
                       sudo sh /root/kor2/restartkor.sh
                       clear -x
                       ;;
               3)
                       clear -x
                       cat /home/remuser/README.md | less
                       clear -x
                       ;;
               4)
                       break
                       ;;
        esac
done
