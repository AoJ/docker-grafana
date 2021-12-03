#!/usr/bin/env bash
set -xeuo pipefail

export GRAFANA_TEMP="$(mktemp -d)"
mkdir -p "$GRAFANA_HOME"

cd "$GRAFANA_TEMP"

curl -L "$GRAFANA_URL" -o grafana.tar.gz
echo "${GRAFANA_SHA256} grafana.tar.gz"                     \
| sha256sum --check --status

tar --strip 1 -C "$GRAFANA_HOME" -xzf grafana.tar.gz
rm -rf "$GRAFANA_TEMP"



INFLUX_URL="https://dl.influxdata.com/influxdb/releases/influxdb-2.0.2_linux_amd64.tar.gz"
INFLUX_SHA256="02164d11dc446541aa1e5a00c298004a19ba8bee4c2930a9a7fee31f8d983f31"

export INFLUX_TEMP="$(mktemp -d)"