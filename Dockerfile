FROM ubuntu:latest
MAINTAINER Jason Mills <jmmills@cpan.org>
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:keithw/mosh
RUN apt-get update -y 
RUN apt-get install -y irssi mosh openssh-server ruby-dev tmux 

RUN gem install tmuxinator

RUN useradd -m irssi
RUN echo "irssi ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/irssi

RUN mkdir /var/run/sshd

RUN mkdir ~irssi/.tmuxinator/
RUN mkdir /home/irssi/.ssh/
ADD irssi.yml /home/irssi/.tmuxinator/irssi.yml

RUN chown irssi -vR /home/irssi/

RUN apt-get purge -y software-properties-common ruby-dev

EXPOSE 22

CMD sudo -u irssi -i tmuxinator start irssi
