#!/bin/bash

#check 3proxy is running
if [[ -z "$(ps -ela | grep 3proxy | grep -v defunct)" ]] && [[ -f "/etc/3proxy/3proxy.cfg" ]] 
then 
     /etc/init.d/3proxy restart
fi

echo "nameserver 8.8.8.8" > /etc/resolv.conf

CONFIGPATH=$(find /profile -name '*.ovpn' -print -type f)
echo Found config file: $CONFIGPATH > /profile/sys.log

openvpn --config $CONFIGPATH \
        --connect-retry 5 15 \
	--connect-retry-max 3
tail -f 
