#!/bin/sh

if !([ -f /var/run/xl2tpd/l2tp-control ]) ; then
     mkdir -p /var/run/xl2tpd
     touch /var/run/xl2tpd/l2tp-control
fi

sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
service rsyslog start

chmod +x /script.sh

# ip a | grep -c ppp

#chmod +x /etc/ppp/ip-up.d/holavpn

#touch /usr/src/1

#chmod 777 /usr/src/1

GW=`ip route | grep default | awk '{ print $3 }'`

DEV=`ip route | grep default | awk '{ print $5 }'`

SERVER='us.vpn.h-vpn.org'

for i in $(grep "^nameserver" /etc/resolv.conf | awk '{print $2}'); do
   ip route add $i via $GW dev $DEV
done

IPA=`/usr/bin/host $SERVER | /usr/bin/awk '{print $4}' | /usr/bin/xargs`

ip route add `echo $IPA | /usr/bin/awk '{print $1}'` via $GW dev $DEV
ip route add `echo $IPA | /usr/bin/awk '{print $2}'` via $GW dev $DEV
ip route add `echo $IPA | /usr/bin/awk '{print $3}'` via $GW dev $DEV
ip route add `echo $IPA | /usr/bin/awk '{print $4}'` via $GW dev $DEV

IP1=`echo $IPA | /usr/bin/awk '{print $1}'`

sed -i "4s/.*/lns = $IP1 /" /etc/xl2tpd/xl2tpd.conf

service xl2tpd start

tail -f /dev/null
#tail -f /var/log/syslog
















