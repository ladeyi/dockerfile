FROM ubuntu:18.04

RUN mkdir /data
WORKDIR /data

RUN apt update

RUN apt install -y openssh-server nodejs npm git 
RUN npm install hexo-cli -g
RUN npm install hexo-server --save
RUN npm install hexo-generator-search --save

RUN mkdir /var/run/sshd && mkdir /root/.ssh

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
VOLUME ["/data", "/root/.ssh"]

CMD    ["/usr/sbin/sshd", "-D"]
