FROM debian:11.4


RUN apt-get update

RUN apt-get install -y iproute2 iputils-ping nfs-common xl2tpd net-tools rsyslog && apt-get clean
RUN apt-get install -y traceroute curl nano mc dnsutils

COPY xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
COPY options.xl2tpd /etc/ppp/options.xl2tpd
COPY chap-secrets /etc/ppp/chap-secrets
#COPY holavpn /etc/ppp/ip-up.d/holavpn
COPY script.sh /
COPY startup.sh /

CMD ["/startup.sh"]
