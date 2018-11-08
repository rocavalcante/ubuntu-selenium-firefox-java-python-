
FROM ubuntu:16.04

LABEL maintaner="Rodrigo Cavalcante <rodrigoibka@gmail.com>"

#============================
# Python & Dependencies
#============================
RUN apt-get update && \
    apt-get install -y software-properties-common vim

RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update -y

RUN apt-get install -y python-software-properties build-essential \
        python3.6 python3.6-dev python3-pip python3.6-venv && \
        apt-get install -y git

RUN export LC_ALL=C.UTF-8
RUN export LANG=C.UTF-8
RUN rm /usr/bin/python && ln -s /usr/bin/python3.6 /usr/bin/python

# update pip
RUN python3.6 -m pip install pip --upgrade && \
        python3.6 -m pip install wheel

RUN apt-get install -y -q --no-install-recommends \
    libgconf2-4 libnss3-1d libxss1 \
    fonts-liberation libappindicator1 xdg-utils \
    software-properties-common \
    curl unzip wget \
    xvfb \
    apt-transport-https \
    libssl-dev \
    rsync \
    devscripts \
    autoconf \
    ssl-cert


#============================
# Firefox
#============================
RUN apt-get update && apt-get install -y firefox

#============================
# Selenium & virtualenv
#============================

RUN pip3 install selenium pyvirtualdisplay \
    virtualenv pipenv

#============================
# geckodriver latest version
#============================

RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver

#===========================
# Node & NPM
#===========================
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

#============================
# Java 8
#============================

RUN echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

#============================
# Check versions
#============================

#RUN node -v
#RUN npm -v
#RUN java -version