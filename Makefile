NAME ?= grafana
VERSION ?= 8.3.0
TARGET ?= /tmp/grafana
pwd = $(shell pwd)

image:
	docker build -f Dockerfile \
	--no-cache \
	--rm \
	-t ${NAME}:${VERSION} \
	.

start:
	docker run \
	-d \
	--restart=always \
	--name grafana \
	--hostname grafana \
	-v /etc/grafana:/opt/grafana/conf \
	-v /var/vm/grafana:/opt/grafana/data \
	-p 10.17.13.1:9091:9091 \
	grafana:latest \
	bin/grafana-server

.PHONY: image start
