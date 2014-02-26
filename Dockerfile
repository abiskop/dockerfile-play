
FROM abiskop/openjdk

##RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list
##RUN echo deb http://archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list
##RUN apt-get update

ADD _install-play.sh /tmp/_install-play.sh
RUN sudo bash /tmp/_install-play.sh

##RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

