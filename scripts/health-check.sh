#!/bin/sh
# Health check script dla KDB.AI Server

set -e

# Sprawdź czy proces kdbai-db działa
if ! pgrep -x "kdbai-db" > /dev/null; then
    echo "❌ KDB.AI Server process not running"
    exit 1
fi

# Sprawdź czy port 8082 jest otwarty
if ! nc -z localhost 8082; then
    echo "❌ Port 8082 not responding"
    exit 1
fi

# Sprawdź czy port 8081 jest otwarty
if ! nc -z localhost 8081; then
    echo "❌ Port 8081 not responding"  
    exit 1
fi

echo "✅ KDB.AI Server is healthy"
exit 0
