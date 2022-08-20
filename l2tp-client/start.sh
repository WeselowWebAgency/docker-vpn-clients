#!/bin/bash

#check 3proxy is running
if [[ -z "$(ps -ela | grep 3proxy | grep -v defunct)" ]] && [[ -f "/etc/3proxy/3proxy.cfg" ]] 
then 
     /etc/init.d/3proxy start
fi

ip r a default via 172.17.0.1 table 100
ip rule add ipproto 17 dport 1701 table 100
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
awk '/^passwords/,/^--/{if (!/passwords/ && !/--/)print > "/etc/ppp/chap-secrets"}' /profile/profile 
awk '/^options.xl2tpd/,/^--/{if (!/options.xl2tpd/ && !/--/)print > "/etc/ppp/options.xl2tpd"}' /profile/profile
awk '/^xl2tpd.conf/,/^--/{if (!/xl2tpd.conf/ && !/--/)print > "/etc/xl2tpd/xl2tpd.conf"}' /profile/profile 
service syslog-ng restart
service xl2tpd start
tail -f 
