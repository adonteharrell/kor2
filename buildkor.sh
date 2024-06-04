#!/bin/bash



#Set enviroment variables
read -p "Enter your Video servers IP: " IP
IP_ADDRESS=$(ip addr show enp0s3 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)
BUILD_DIR="/root/kor2"
HTTPD_USERNAME="admin"
HTTPD_PASSWORD="korcese"
VID_DIR="/videos"
WIN_USER="Korcese"
WIN_PW="korcese"
WIN_DIR="//$IP/Videos"

#Install podman and enable service.
yum install docker -y
yum install podman -y
systemctl enable --now podman
systemctl enable --now docker

#Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod 755 /usr/local/bin/docker-compose

#Install epel software repo
sudo yum install epel-release -y 

#Install rpm fusion repo
sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm -y

#Install ffmpeg
sudo yum install ffmpeg ffmpeg-devel -y

#Mount your Windows drive to Linux
yum install cifs-utils -y

mkdir $VID_DIR
sudo mount -t cifs $WIN_DIR $VID_DIR -o username=$WIN_USER,password=$WIN_PW

fstab="$WIN_DIR $VID_DIR cifs username=$WIN_USER,password=$WIN_PW,iocharset=utf8,uid=1000,gid=1000 0 0"

if ! grep -qF "$fstab" /etc/fstab; then
    # If the entry does not exist, add it to /etc/fstab
    echo "$fstab" | sudo tee -a /etc/fstab
else
    echo "Entry already exists in fstab."
fi

#Convert all movie files to .mp4
cd $VID_DIR

for i in *.mkv *.avi; do
    sudo ffmpeg -hide_banner -loglevel error -y -i "$i" -codec copy "${i%.*}.mp4"
done

#Remove spaces
cp "$BUILD_DIR/delimiter.sh" "$VID_DIR/delimiter.sh"

sh "$VID_DIR/delimiter.sh"

rm -f "$VID_DIR/delimiter.sh"

rm -f "$VID_DIR"/*.mkv

#Build korcese environment
cd $BUILD_DIR
docker-compose up -d 
#Start container and move movies
docker exec -it korcese sh convert.sh
docker exec -it korcese bash -c "echo $HTTPD_PASSWORD | htpasswd -ci /movies/.htpasswd $HTTPD_USERNAME" 
echo "Your site is available. Type this address into any browser: $IP_ADDRESS:9511"

#Install firefox
yum install firefox -y

chmod +x ./start_firefox.sh
chmod +x ./restartkor.sh
cp ./start_firefox.sh /home/korcese/start_firefox.sh
cp ./start_firefox.sh /home/korcese/restartkor.sh 

#Enable autologin
rm -f /etc/gdm/custom.conf
cp ./custom.conf /etc/gdm/custom.conf

#Make sure firefox opens at boot
mkdir -p /home/korcese/.config/autostart
cp ./korcese.desktop /home/korcese/.config/autostart/korcese.desktop

sudo systemctl set-default graphical.target
sudo reboot
