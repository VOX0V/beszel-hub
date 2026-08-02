ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

# Installation des paquets requis
RUN apk add --no-cache curl jq tar

# Script d'installation multi-architecture corrigé
ARG BESZEL_VERSION=0.18.7
RUN set -x && \
    ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then BIN_ARCH="amd64"; \
    elif [ "$ARCH" = "aarch64" ]; then BIN_ARCH="arm64"; \
    elif [ "$ARCH" = "armv7l" ]; then BIN_ARCH="armv7"; \
    else echo "Architecture non supportée: $ARCH" && exit 1; fi && \
    curl -L "https://github.com{BESZEL_VERSION}/beszel_${BESZEL_VERSION}_linux_${BIN_ARCH}.tar.gz" | tar -xz -C /usr/bin/

RUN mkdir -p /config/beszel_data

# Configuration des variables d'environnement pour désactiver le blocage d'Iframe natif
ENV DISABLE_X_FRAME_OPTIONS=true

EXPOSE 8090

CMD ["/usr/bin/beszel", "serve", "--http", "0.0.0.0:8090", "--dir", "/config/beszel_data"]
