FROM relateiq/oracle-java8
MAINTAINER Fred Chu <zhuzhu@cpan.org>

# install xvfb and other X dependencies for IB
RUN apt-get update -y \
    && apt-get install -y xvfb libxrender1 libxtst6 x11vnc socat unzip\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

WORKDIR /tmp
RUN mkdir /root/IBController &&  wget https://github.com/zz/ib-controller/releases/download/2.13.1-api/IBController-2.13.1-api.zip && \
	wget http://download2.interactivebrokers.com/download/unixmacosx_latest.jar
WORKDIR /opt
RUN unzip /tmp/IBController-2.13.1-api.zip && jar xf /tmp/unixmacosx_latest.jar && \
	chmod a+x IBController/*.sh

COPY config/IBController.ini /root/IBController/IBController.ini
COPY config/jts.ini /opt/IBJts
COPY init/xvfb_init /etc/init.d/xvfb
COPY init/vnc_init /etc/init.d/vnc
COPY bin/xvfb-daemon-run /usr/bin/xvfb-daemon-run
COPY bin/run-gateway /usr/bin/run-gateway

# vnc (optional)
# set your own password to launch vnc
# ENV VNC_PASSWORD doughnuts

# 5900 for VNC, 4003 for the gateway API via socat
EXPOSE 5900 4003
VOLUME /root

ENV DISPLAY :0

CMD ["/usr/bin/run-gateway"]
