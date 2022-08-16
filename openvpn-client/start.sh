#!/bin/bash

#check 3proxy is running
#if [ -z "$(ps -ela | grep 3proxy | grep -v defunct)" ]; then /etc/init.d/3proxy restart; fi
/etc/init.d/3proxy restart

echo "nameserver 8.8.8.8" > /etc/resolv.conf

CONFIGPATH=$(find /profile -name '*.ovpn' -print -type f)

openvpn --config $CONFIG \
        --connect-retry 5 15 \
	--connect-retry-max 3
tail -f 
