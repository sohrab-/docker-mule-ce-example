#!/bin/bash

cd /tmp

# install Oracle JRE
wget --no-check-certificate --no-cookies \
     --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jre-7u75-linux-x64.tar.gz
sudo tar -zxf jre-7u75-linux-x64.tar.gz -C /opt
sudo ln -s /opt/jre1.7.0_75 /opt/jre
sudo update-alternatives --install /usr/bin/java java /opt/jre/bin/java 100

export JAVA_HOME=/opt/jre
export JRE_HOME=$JAVA_HOME

# install Mule CE
wget --no-check-certificate \
    https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.6.1/mule-standalone-3.6.1.tar.gz
sudo tar -zxf mule-standalone-3.6.1.tar.gz -C /opt
sudo ln -s /opt/mule-standalone-3.6.1 /opt/mule

export MULE_HOME=/opt/mule
export PATH=$PATH:$MULE_HOME/bin

# install Mule app
cp sample-app.zip /opt/mule/apps/

# run server
mule