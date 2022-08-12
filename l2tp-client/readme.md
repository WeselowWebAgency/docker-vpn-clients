## Подготовка

Можно использовать dos2unix:

```
find . -name '*' | xargs dos2unix
```

Замены в файле ./profile/profile: @login, @password, @server

## Команда сборки

```
docker build -f . -t aweselow/linux-l2tp-client
```

## Команда запуска
```
docker run -d --rm \
	--cap-add=net_admin \
	--device=/dev/ppp \
	--name holavpn \
	--mount type=bind,source=$(pwd)/profile/,target=/profile/  \
	-v /path/3proxy.cfg:/etc/3proxy/3proxy.cfg
	aweselow/linux-l2tp-client
```