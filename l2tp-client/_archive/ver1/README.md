# hola-vpn-client
Клиент для HolaVpn, упакованный в докер.

## Команды

Собрать контейнер:
```
docker build -t l2tp .
```

Команда запуска с добавление гугл nameserver:
```
docker run -d --rm \
           --name l2tp \
           --cap-add=NET_ADMIN \
           --device=/dev/ppp \
           --dns 8.8.8.8 \
           l2tp
```

Проверить внешний айпишник:
```
curl api.ipify.org
```
