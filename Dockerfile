FROM debian:wheezy
MAINTAINER sohrab <sohrab@sixtree.com.au>

# install supporting tools
RUN apt-get update
RUN apt-get install -y procps wget

WORKDIR /tmp

# install Oracle JRE
RUN wget --no-check-certificate --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jre-7u75-linux-x64.tar.gz
RUN tar -zxf jre-7u75-linux-x64.tar.gz -C /opt
RUN ln -s /opt/jre1.7.0_75 /opt/jre
RUN update-alternatives --install /usr/bin/java java /opt/jre/bin/java 100

ENV JAVA_HOME /opt/jre
ENV JRE_HOME $JAVA_HOME

# install Mule CE
RUN wget --no-check-certificate \
         https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.6.1/mule-standalone-3.6.1.tar.gz
RUN tar -zxf mule-standalone-3.6.1.tar.gz -C /opt
RUN ln -s /opt/mule-standalone-3.6.1 /opt/mule

ENV MULE_HOME /opt/mule
ENV PATH $PATH:$MULE_HOME/bin

# install Mule app
COPY sample-app.zip /opt/mule/apps/

# run server
CMD ["mule"]