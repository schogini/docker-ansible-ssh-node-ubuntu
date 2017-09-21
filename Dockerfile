#FROM rastasheep/ubuntu-sshd:14.04
FROM ubuntu:trusty
MAINTAINER Sreeprakash Neelakantan <sree@schogini.com>

RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get install -y wget tree curl nano && \
    apt-get install -y openssh-server
RUN mkdir /var/run/sshd


# docker build -t schogini/ubuntu-sshd .
# docker run -d -P --name node1 schogini/ubuntu-sshd
# docker port node1 22
# ssh root@localhost -p $(docker port node1 22|sed 's/^.*://') \
# -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 
# service apache2 restart
# echo "Hello" > /var/www/html/sree.txt
# curl localhost/sree.txt

#RUN apt-get install -y openssh-server

RUN passwd -d root
#RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#IgnoreUserKnownHosts\s+.*/IgnoreUserKnownHosts yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitEmptyPasswords\s+.*/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 80

CMD    ["/usr/sbin/sshd", "-D"]
