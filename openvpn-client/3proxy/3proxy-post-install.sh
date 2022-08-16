#!/bin/bash
cp -vf /tmp-proxy/lib/* /usr/lib/
cp -vf /tmp-proxy/bin/* /usr/bin/
cp -vf /tmp-proxy/man3/* /usr/share/man/man3/
cp -vf /tmp-proxy/man8/* /usr/share/man/man8/
cp -vf /tmp-proxy/init.d/* /etc/init.d/
update-rc.d 3proxy defaults
