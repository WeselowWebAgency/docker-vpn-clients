APPLICATION := holal2tp

list:
	docker ps -a
	docker image ls
build: 
	docker build -f xl2tptest.dockerfile . -t holavpn:latest
clean:
	docker stop holavpn
	docker system prune -f
	docker rmi holavpn:latest
test: run 
	@sleep 5
	@docker exec -it holavpn sh -c "curl ifconfig.io"
	
run: build
	docker run -d --rm --cap-add=net_admin --device=/dev/ppp --name holavpn --mount type=bind,source=$(shell pwd)/profile/,target=/profile/  holavpn
cli: run
	docker exec -it holavpn bash

.ONESHELL:
tests: 
	echo "myip $(shell docker exec -it holavpn sh -c "curl ifconfig.io")"	
	if [ -e $(shell docker exec -it holavpn sh -c "ping -c3 8.8.8.8 &>/dev/null") ]; then echo "ping ok";fi
	
