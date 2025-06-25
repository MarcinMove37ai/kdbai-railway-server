# Deployment Guide

## Zmienne środowiskowe Railway

Ustaw następujące zmienne w Railway dashboard:

### Wymagane:
- `KDB_LICENSE_B64` - Licencja KDB.AI w formacie base64
- `VDB_DIR` - `/tmp/kx/data/vdb`
- `THREADS` - `8` (lub liczba CPU cores)

### Opcjonalne:
- `KDB_LOG_LEVEL` - `INFO`
- `PORT` - `8082` (Railway ustawi automatycznie)

## GitHub Secrets

Ustaw w GitHub repo settings:

- `KX_EMAIL` - Email do KX registry
- `KX_BEARER_TOKEN` - Bearer token z KX
- `RAILWAY_TOKEN` - Token Railway CLI
- `KDB_LICENSE_B64` - Licencja base64

## Deployment

1. Push do main branch
2. GitHub Actions automatycznie zbuduje obraz
3. Railway automatycznie wdroży nową wersję
