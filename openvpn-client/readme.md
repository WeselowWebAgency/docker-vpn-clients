## Подготовка

Можно использовать dos2unix:

```
find . -name '*' | xargs dos2unix
```


## Команда сборки

```
docker build . -t aweselow/linux-openvpn-client:latest
```

Отправить в репозиторий: 
```
docker push aweselow/linux-openvpn-client:latest
```

## Команда запуска
```
docker run -d --rm \
    --name=openvpn \
	--hostname=openvpn \
	-p 8002:8001 \
	-p 9002:9001 \
	--cap-add=SYS_MODULE  \
	--cap-add=net_admin \
	--device /dev/net/tun  \	 
	-v /path/3proxy.cfg:/etc/3proxy/3proxy.cfg \
	-v /path/profileDir:/profile/ \
	aweselow/linux-openvpn-client
```