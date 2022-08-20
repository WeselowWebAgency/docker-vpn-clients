#!/bin/bash

#check 3proxy is running
if [[ -z "$(ps -ela | grep 3proxy | grep -v defunct)" ]] && [[ -f "/etc/3proxy/3proxy.cfg" ]] 
then 
     /etc/init.d/3proxy restart
fi

echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Create config
if ! [[ -f "/profile/$ConfigFilename" ]] 
then 
     echo "Cannot find config file: /profile/$ConfigFilename " >> /profile/sys.log
     exit 1
fi

echo "Found config file: /profile/$ConfigFilename" >> /profile/sys.log

openvpn --config /profile/$ConfigFilename \
        --connect-retry 5 15 \
	--connect-retry-max 3
	
tail -f 
