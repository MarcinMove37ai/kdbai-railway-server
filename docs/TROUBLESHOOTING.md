# Troubleshooting

## Częste problemy

### 1. Błąd licencji
```
Error: License validation failed
```
**Rozwiązanie**: Sprawdź `KDB_LICENSE_B64` w Railway

### 2. Błąd dostępu do KX registry
```
Error: pull access denied for portal.dl.kx.com/kdbai-db
```
**Rozwiązanie**: Sprawdź `KX_EMAIL` i `KX_BEARER_TOKEN`

### 3. Port nie odpowiada
```
Health check failed - port not responding
```
**Rozwiązanie**: Sprawdź czy kontener się uruchomił w Railway logs

## Logi

### Railway
```bash
railway logs --follow
```

### GitHub Actions
Sprawdź w zakładce "Actions" na GitHub

## Support

- Railway: railway.app/help  
- KDB.AI: support.kx.com
