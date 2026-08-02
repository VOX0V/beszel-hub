#!/bin/sh

INGRESS_PATH=$(jq -r '.ingress_path' /data/options.json)
export APP_URL="http://localhost${INGRESS_PATH}"
echo "[run.sh] APP_URL=${APP_URL}"

exec /usr/bin/beszel serve --http 0.0.0.0:8090 --dir /config/beszel_data
