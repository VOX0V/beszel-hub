#!/bin/sh

echo "[run.sh] SUPERVISOR_TOKEN présent : $([ -n "$SUPERVISOR_TOKEN" ] && echo oui || echo NON)"

RESPONSE=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
  http://supervisor/addons/self/info)

echo "[run.sh] Réponse brute de l'API Supervisor : ${RESPONSE}"

INGRESS_ENTRY=$(echo "$RESPONSE" | jq -r '.data.ingress_entry // empty' 2>/dev/null)

if [ -n "$INGRESS_ENTRY" ]; then
  export APP_URL="http://localhost${INGRESS_ENTRY}"
  echo "[run.sh] Ingress détecté — APP_URL=${APP_URL}"
else
  echo "[run.sh] ATTENTION: chemin ingress introuvable, démarrage sans APP_URL"
fi

exec /usr/bin/beszel serve --http 0.0.0.0:8090 --dir /config/beszel_data
