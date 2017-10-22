FROM maven:3.2-jdk-7-onbuild
MAINTAINER hidetomo

# create user
RUN useradd hidetomo
RUN mkdir /home/hidetomo && chown hidetomo:hidetomo /home/hidetomo

# sudo
RUN apt-get -y update
RUN apt-get -y install sudo
RUN echo "hidetomo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# change user and dir
USER hidetomo
WORKDIR /home/hidetomo
ENV HOME /home/hidetomo

# alias
RUN echo "alias ls='ls --color'" >> .bashrc
RUN echo "alias ll='ls -la'" >> .bashrc

# common apt-get
RUN sudo apt-get -y install vim
RUN sudo apt-get -y install less

# change dir
RUN mkdir /home/hidetomo/spring
WORKDIR /home/hidetomo/spring

# spring
COPY pom.xml pom.xml
COPY src/main/java/com/dockerforjavadevelopers/hello/Application.java src/main/java/com/dockerforjavadevelopers/hello/Application.java
COPY src/main/java/com/dockerforjavadevelopers/hello/HelloController.java src/main/java/com/dockerforjavadevelopers/hello/HelloController.java

# change dir
WORKDIR /home/hidetomo

# start
COPY start.sh start.sh
RUN sudo chown hidetomo:hidetomo start.sh
CMD ["/bin/bash", "/home/hidetomo/start.sh"]
