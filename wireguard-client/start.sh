#!/bin/bash

#check 3proxy is running
if [[ -z "$(ps -ela | grep 3proxy | grep -v defunct)" ]] && [[ -f "/etc/3proxy/3proxy.cfg" ]] 
then 
     /etc/init.d/3proxy start
fi

echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Create config
#CONFIGPATH=$(find /profile -name '*.ovpn' -print -type f)
if ! [[ -f "/profile/$ConfigFilename" ]] 
then 
     echo "Cannot find config file: /profile/$ConfigFilename " >> /profile/sys.log
     exit 1
fi

echo "Found config file: /profile/$ConfigFilename" >> /profile/sys.log

cp /profile/$ConfigFilename /etc/wireguard/wg0.conf
echo "Copying config file: $CONFIGPATH to /etc/wireguard/wg0.conf" >> /profile/sys.log


# Check for net.ipv4.conf.all.src_valid_mark=1
if [[ "$(cat /proc/sys/net/ipv4/conf/all/src_valid_mark)" != "1" ]]; then
    echo "sysctl net.ipv4.conf.all.src_valid_mark=1 is not set" >> /profile/sys.log
    exit 1
fi

# The net.ipv4.conf.all.src_valid_mark sysctl is set when running the Docker container, so don't have WireGuard also set it
sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick
wg-quick up wg0

tail -f 
