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

## Ремарки

Для запуска Wireguad в контейнере надо:

1. Добавить пакет `openresolv`

2. При запуске добавлять переменную `--sysctl net.ipv4.conf.all.src_valid_mark=1`. Внутри контейнера добавить не получится, так как не хватит прав или надо использовать режим `--priviledged`.

3. Внутри контейнера отредактировать `/usr/bin/wg-quick`, чтобы он не пытался установить `--sysctl net.ipv4.conf.all.src_valid_mark=1`:

```
# The net.ipv4.conf.all.src_valid_mark sysctl is set when running the Docker container, 
# so don't have WireGuard also set it
sed -i "s:sysctl -q net.ipv4.conf.all.src_valid_mark=1:echo Skipping setting net.ipv4.conf.all.src_valid_mark:" /usr/bin/wg-quick
```


## Команда запуска

`ConfigFilename` - это имя файла с конфигом в папке `/profile/` контейнера

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
	-e ConfigFilename=config.conf \
	-v /path/3proxy.cfg:/etc/3proxy/3proxy.cfg \
	-v /path/profileDir:/profile/ \
	aweselow/linux-wireguard-client
```