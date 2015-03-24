FROM debian:wheezy
MAINTAINER sohrab <sohrab@sixtree.com.au>

ENV JRE_DOWNLOAD_FILE jre-7u75-linux-x64.tar.gz
ENV JRE_DOWNLOAD_URL http://download.oracle.com/otn-pub/java/jdk/7u75-b13/$JRE_DOWNLOAD_FILE
ENV JRE_EXPANDED_FILE jre1.7.0_75

ENV MULE_VERSION 3.6.1

# install supporting tools
RUN apt-get update && \
    apt-get install -y procps ruby wget && \
    apt-get clean && \
    apt-get purge 


WORKDIR /tmp

# install Oracle JRE
RUN wget --no-check-certificate --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         $JRE_DOWNLOAD_URL && \
    tar -zxf $JRE_DOWNLOAD_FILE -C /opt && \
    ln -s /opt/$JRE_EXPANDED_FILE /opt/jre && \
    update-alternatives --install /usr/bin/java java /opt/jre/bin/java 100 && \
    rm -rf $JRE_EXPANDED_FILE

ENV JAVA_HOME /opt/jre
ENV JRE_HOME $JAVA_HOME

# install Mule CE
RUN wget --no-check-certificate \
         https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.tar.gz && \
    tar -zxf mule-standalone-${MULE_VERSION}.tar.gz -C /opt && \
    ln -s /opt/mule-standalone-${MULE_VERSION} /opt/mule && \
    rm -rf mule-standalone-${MULE_VERSION}.tar.gz /opt/mule/apps/default /opt/mule/src

ENV MULE_HOME /opt/mule
ENV PATH $PATH:$MULE_HOME/bin

# install Mule app
COPY sample-app.zip /opt/mule/apps/

# run Mule server as non-root
RUN useradd mule && \
    chown -RL mule /opt/mule
ENV RUN_AS_USER mule

VOLUME /opt/mule/logs
EXPOSE 9000

# run server
COPY sample-app.properties.erb /build/sample-app.properties.erb
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]