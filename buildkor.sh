#!/bin/bash

#Set enviroment variables
BUILD_DIR="/root/kor"
HTTPD_USERNAME="honeybuns"
HTTPD_PASSWORD="smelly"
VID_DIR="/videos"
WIN_USER="Dummy"
WIN_PW="youdumb"
WIN_DIR="//10.0.0.236/Videos2"

#Install podman and enable service.
yum install docker -y
yum install podman -y
systemctl enable --now podman

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
