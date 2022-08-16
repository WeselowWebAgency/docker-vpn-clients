FROM debian:11 as build

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp-proxy
COPY ./3proxy/* /tmp-proxy/

RUN apt-get update &&\
	apt-get install apt-utils dos2unix gcc wget procps -y &&\
	dos2unix -k 3proxy-linux-install.sh &&\	
	dos2unix -k 3proxy-post-install.sh &&\
	chmod +x *.sh &&\
	./3proxy-linux-install.sh 


FROM debian:11 as publish
MAINTAINER white_ghost

EXPOSE 8001
EXPOSE 9001

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app
COPY --from=build /tmp-proxy/ /tmp-proxy/
COPY start.sh .

RUN /tmp-proxy/3proxy-post-install.sh &&\
	rm -R /tmp-proxy &&\
	apt-get -qq update &&\
	apt-get -qq install -y openvpn iproute2 curl iputils-ping dnsutils traceroute syslog-ng dos2unix &&\
	apt-get autoremove -y && apt-get clean &&\ 
	dos2unix -k start.sh &&\
	chmod +x start.sh

CMD ./start.sh
