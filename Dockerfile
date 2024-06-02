#FROM docker.io/dokken/centos-stream-8
FROM docker.io/centos/httpd-24-centos7

USER root
#Make directories
#RUN yum install httpd -y
RUN mkdir /korcese 
RUN mkdir /movies
RUN mkdir /videos 

#Copy conf file
#COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY welcome.conf /etc/httpd/conf.d/welcome.conf
#Copy scripts 
COPY ./scripts/* /korcese/ 
COPY .htaccess /movies/.htaccess
#CD into korcese dir
WORKDIR /korcese
RUN mv htmltemp.sh /movies
RUN mv lv.jpg /movies
RUN mv styles.css /movies
RUN mv miranda.gif /movies
RUN mv delimiter.sh /movies
RUN mv indextemp.sh /movies

#Run quick move script

