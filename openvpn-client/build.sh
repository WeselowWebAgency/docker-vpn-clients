#!/bin/bash

echo == Converting files ...
find . -name '*' | xargs dos2unix
find . -name '*.sh' | xargs chmod +x  
echo == Converting files ... done!
echo

echo == Building Docker Image ...
docker build . -t aweselow/linux-openvpn-client:latest
echo == Building Docker Image ... done!
echo

echo == Pushing Docker Image to Hub ...
docker push aweselow/linux-openvpn-client:latest
echo == Pushing Docker Image to Hub ... done!
echo
