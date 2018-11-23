FROM ubuntu:latest
RUN apt-get update
RUN apt-get upgrade
RUN useradd -m ntd5
RUN apt-get install -y libxml2 kmod
RUN mkdir -p /usr/share/desktop-directories
RUN mkdir -p /usr/share/applications
ADD anyconnect-current/ /root/anyconnect
WORKDIR /root/anyconnect/vpn
RUN yes | ./vpn_install.sh
RUN apt-get install -y libatk1.0-0 libgdk-pixbuf2.0-0 libgtk2.0-0
RUN apt-get install -y libpangox-1.0-0 libpangoxft-1.0-0
RUN apt-get install -y xterm
WORKDIR /home/ntd5
ADD --chown=ntd5:ntd5 entrypoint.sh /home/ntd5
ENTRYPOINT [ "/bin/sh", "/home/ntd5/entrypoint.sh" ]
