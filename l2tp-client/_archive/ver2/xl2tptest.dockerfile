FROM debian:11
MAINTAINER white_ghost

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && apt-get -qq install -y xl2tpd iproute2 curl iputils-ping dnsutils traceroute syslog-ng 
RUN sed -i 's/#SYSLOGNG/SYSLOGNG/' /etc/default/syslog-ng 
COPY start.sh .
CMD ./start.sh
