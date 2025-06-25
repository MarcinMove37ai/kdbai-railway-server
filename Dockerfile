# KDB.AI Server Dockerfile for Railway Deployment
# Zgodny z Docker best practices 2025

# Multi-stage build - etap 1: przygotowanie
FROM alpine:3.21 AS base

# Metadane obrazu
LABEL maintainer="your-email@domain.com" \
      description="KDB.AI Server for Railway deployment" \
      version="1.0.0"

# Instalacja podstawowych narzędzi
RUN apk add --no-cache \
    ca-certificates \
    curl \
    && rm -rf /var/cache/apk/*

# Etap 2: budowa aplikacji
FROM portal.dl.kx.com/kdbai-db:latest AS production

# Zmienne środowiskowe
ENV VDB_DIR="/tmp/kx/data/vdb" \
    THREADS="8" \
    KDB_LOG_LEVEL="INFO"

# Tworzenie katalogów roboczych
RUN mkdir -p /tmp/kx/data && chmod 755 /tmp/kx/data

# Kopiowanie pliku health check
COPY --chown=kdbai:kdbai scripts/health-check.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/health-check.sh


# Eksponowanie portów
EXPOSE 8081 8082

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD /usr/local/bin/health-check.sh

# Volume dla danych (opcjonalnie)
VOLUME ["/tmp/kx/data"]

# Komenda startowa
CMD ["sh", "-c", "exec /opt/kx/bin/kdbai-db"]
