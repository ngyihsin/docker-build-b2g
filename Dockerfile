FROM ubuntu:18.04
MAINTAINER Seinlin <seinlin.manug@gmail.com>

RUN apt-get update

RUN dpkg --add-architecture i386
RUN dpkg --add-architecture amd64

RUN apt-get install -y --no-install-recommends ssh libxt6 bc autoconf2.13 bison bzip2 ccache curl flex gawk gcc g++ g++-multilib git lib32ncurses5-dev lib32z1-dev libgconf2-dev zlib1g zlib1g-dev libgl1-mesa-dev libx11-dev make zip lzop libxml2-utils openjdk-8-jdk nodejs unzip python vim mkisofs

RUN apt-get install subversion -y
RUN apt-get install sudo -y
RUN apt-get install libpulse-dev -y
RUN apt-get install libssh-dev cmake -y
RUN apt-get install -qy clang-5.0 lld-5.0
RUN apt-get install libcairo2-dev -y
RUN apt-get install libpango1.0-dev -y
RUN apt-get install nasm yasm -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install libgtk3* -y
RUN apt-get install libdbus-1-dev -y
RUN apt-get install libdbus-glib-1-dev -y
RUN apt-get install rsync -y
RUN apt-get install libgtk2.0 -y
RUN apt-get install libwww-perl -y

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs build-essential
RUN npm install -g npm@4

RUN apt-get remove -y --purge cmdtest
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y yarn

RUN apt-get install -y file less

ENV LC_ALL C.UTF-8

ENV USER vincent

RUN echo "root:password" | chpasswd
RUN useradd -ms /bin/bash $USER
RUN echo "$USER:password" | chpasswd
RUN usermod -aG sudo $USER
USER $USER
ENV HOME /home/$USER
ENV SHELL /bin/bash
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $HOME/.cargo/bin:$PATH
RUN echo "export PATH=~/.cargo/bin:$PATH" >> ~/.bashrc
RUN rustup target add armv7-linux-androideabi
RUN cargo install sccache
RUN cargo install cbindgen --force
