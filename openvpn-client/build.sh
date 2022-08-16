#!/bin/bash

echo == Converting files ...
find . -name '*' | xargs dos2unix

echo == Building Docker Image ...
docker build . -t aweselow/linux-openvpn-client:latest

echo == Pushing Docker Image to Hub ...
docker push aweselow/linux-openvpn-client:latest