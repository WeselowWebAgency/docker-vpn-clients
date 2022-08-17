## Подготовка

Можно использовать dos2unix:

```
find . -name '*' | xargs dos2unix
```


## Команда сборки

```
docker build . -t aweselow/linux-wireguard-client:latest &&\
docker push aweselow/linux-wireguard-client:latest
```

## Команда запуска
```
docker run -d --rm \
    --name=wireguard \
	--hostname=wireguard \
	-p 8002:8001 \
	-p 9002:9001 \
	--cap-add=SYS_MODULE  \
	--cap-add=net_admin \
	--device /dev/net/tun  \
	--sysctl net.ipv4.conf.all.src_valid_mark=1 \
	--sysctl net.ipv4.ip_forward=1 \
	-v /path/3proxy.cfg:/etc/3proxy/3proxy.cfg \
	-v /path/profileDir:/profile/ \
	aweselow/linux-wireguard-client
```