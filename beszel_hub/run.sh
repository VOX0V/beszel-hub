#!/bin/sh
set -e

# Récupère le chemin ingress attribué par le Supervisor pour cet add-on
INGRESS_ENTRY=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
  http://supervisor/addons/self/info | jq -r '.data.ingress_entry // empty')

if [ -n "$INGRESS_ENTRY" ]; then
  export APP_URL="http://localhost${INGRESS_ENTRY}"
  echo "[run.sh] Ingress détecté — APP_URL=${APP_URL}"
else
  echo "[run.sh] ATTENTION: impossible de récupérer le chemin ingress (SUPERVISOR_TOKEN manquant ou API injoignable)"
fi

exec /usr/bin/beszel serve --http 0.0.0.0:8090 --dir /config/beszel_data
