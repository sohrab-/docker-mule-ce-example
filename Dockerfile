FROM debian:wheezy
MAINTAINER sohrab <sohrab@sixtree.com.au>

# install supporting tools
RUN apt-get update && \
    apt-get install -y procps wget && \
    apt-get clean && \
    apt-get purge 


WORKDIR /tmp

# install Oracle JRE
RUN wget --no-check-certificate --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jre-7u75-linux-x64.tar.gz && \
    tar -zxf jre-7u75-linux-x64.tar.gz -C /opt && \
    ln -s /opt/jre1.7.0_75 /opt/jre && \
    update-alternatives --install /usr/bin/java java /opt/jre/bin/java 100 && \
    rm -rf jre-7u75-linux-x64.tar.gz

ENV JAVA_HOME /opt/jre
ENV JRE_HOME $JAVA_HOME

# install Mule CE
RUN wget --no-check-certificate \
         https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.6.1/mule-standalone-3.6.1.tar.gz && \
    tar -zxf mule-standalone-3.6.1.tar.gz -C /opt && \
    ln -s /opt/mule-standalone-3.6.1 /opt/mule && \
    rm -rf mule-standalone-3.6.1.tar.gz /opt/mule/apps/default /opt/mule/src

ENV MULE_HOME /opt/mule
ENV PATH $PATH:$MULE_HOME/bin

# install Mule app
COPY sample-app.zip /opt/mule/apps/

# run server
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]