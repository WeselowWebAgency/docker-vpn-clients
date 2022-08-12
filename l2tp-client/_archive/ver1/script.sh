#!/bin/sh
GW=`ip route | grep default | awk '{ print $3 }'`

DEV=`ip route | grep default | awk '{ print $5 }'`

SERVER='us.vpn.h-vpn.org'

for i in $(grep "^nameserver" /etc/resolv.conf | awk '{print $2}'); do
   ip route add $i via $GW dev $DEV
done

IPA=`/usr/bin/host $SERVER | /usr/bin/awk '{print $4}' | /usr/bin/xargs`

ip route add `echo IPA | /usr/bin/awk '{print $1}'` via $GW dev $DEV
ip route add `echo IPA | /usr/bin/awk '{print $2}'` via $GW dev $DEV
ip route add `echo IPA | /usr/bin/awk '{print $3}'` via $GW dev $DEV
ip route add `echo IPA | /usr/bin/awk '{print $4}'` via $GW dev $DEV

IP1=`echo IPA | /usr/bin/awk '{print $1}'`

sed -i '4s/.*/lns = $IP1 /' /etc/xl2tpd/xl2tpd.conf
