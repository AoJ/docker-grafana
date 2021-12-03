#!/usr/bin/env bash
set -xeuo pipefail
# https://portal.influxdata.com/downloads/
INFLUX_URL="https://dl.influxdata.com/influxdb/releases/influxdb-2.0.2_linux_amd64.tar.gz"
INFLUX_SHA256="02164d11dc446541aa1e5a00c298004a19ba8bee4c2930a9a7fee31f8d983f31"
INFLUX_HOME="/opt/influx"

export INFLUX_TEMP="$(mktemp -d)"
mkdir -p "$INFLUX_HOME"

cd "$INFLUX_TEMP"

curl -L "$INFLUX_URL" -o influx.tar.gz
echo "${INFLUX_SHA256} influx.tar.gz"                     \
| sha256sum --check --status

tar --strip 1 -C "$INFLUX_HOME" -xzf influx.tar.gz
rm -rf "$INFLUX_TEMP"


/opt/influx/influxd --engine-path /opt/influx/data --http-bind-address ":9092" --reporting-disabled



	docker run --rm -ti --user $(id -u letsencrypt):$(id -g letsencrypt) -v /etc/letsencrypt:/etc/letsencrypt -v /var/log/letsencrypt:/var/log/letsencrypt aoj/certbook:latest certbot renew --logs-dir /var/log/letsencrypt --config-dir /etc/letsencrypt --work-dir /etc/letsencrypt/work

docker run -ti --rm -p 10.17.13.1:8089:8089 -p 10.17.13.1:8090:8090 -v $PWD:/etc/traefik traefik:latest --api.insecure=true