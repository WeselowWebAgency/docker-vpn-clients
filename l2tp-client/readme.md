## Подготовка

Можно использовать dos2unix:

```
find . -name '*' | xargs dos2unix
```

Замены в файле ./profile/profile: @login, @password, @server

## Команда сборки

```
docker build . -t aweselow/linux-l2tp-client:latest
```

Отправить в репозиторий: 
```
docker push aweselow/linux-l2tp-client:latest
```

## Команда запуска

`ConfigFilename` - это имя файла с конфигом в папке `/profile/` контейнера.

`/path/3proxy.cfg` - путь к конфигу 3proxy.

`/path/profileDir` - путь к папке с файлами профиля.

```
docker run -d --rm \
    --name=l2tp \
	--hostname=l2tp \
	-p 8002:8001 \
	-p 9002:9001 \
	--cap-add=SYS_MODULE  \
	--cap-add=net_admin \
	--device=/dev/ppp \
	-e ConfigFilename=config.conf \
	-v /path/3proxy.cfg:/etc/3proxy/3proxy.cfg \
	-v /path/profileDir:/profile/ \
	aweselow/linux-l2tp-client
```


`--mount type=bind,source=$(pwd)/profile/,target=/profile/  \`