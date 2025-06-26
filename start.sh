#!/bin/sh
# Finalny skrypt startowy dla KDB.AI na Railway

# Zatrzymaj skrypt w przypadku błędu
set -e

echo "--- Uruchamianie niestandardowego skryptu startowego KDB.AI ---"

# --- Walidacja zmiennych z DEPLOYMENT.md ---
if [ -z "$KDB_LICENSE_B64" ]; then
    echo "[BŁĄD] Zmienna środowiskowa KDB_LICENSE_B64 nie jest ustawiona w Railway!"
    exit 1
fi

if [ -z "$THREADS" ]; then
    echo "[OSTRZEŻENIE] Zmienna THREADS nie jest ustawiona. Używam domyślnie 1 rdzenia."
    THREADS=1
fi

# --- Logika tworzenia licencji ---
echo "Tworzenie pliku licencji z zmiennej środowiskowej..."
echo -n "$KDB_LICENSE_B64" | base64 -d > /tmp/kc.lic
export QLIC=/tmp
echo "Plik licencji utworzony."

# --- Logika uruchomienia aplikacji z ograniczeniem rdzeni ---
CORE_RANGE="0-$(($THREADS-1))"
EXECUTABLE="/opt/kx/bin/kdbai-db"

echo "Sprawdzanie pliku wykonywalnego: $EXECUTABLE"
if [ ! -x "$EXECUTABLE" ]; then
    echo "[BŁĄD] Plik $EXECUTABLE nie istnieje lub nie ma uprawnień do wykonania!"
    exit 1
fi

echo "Uruchamianie procesu KDB.AI na rdzeniach: $CORE_RANGE..."
# Używamy 'exec', aby zastąpić proces powłoki, oraz 'taskset' do ograniczenia rdzeni
exec taskset -c "$CORE_RANGE" "$EXECUTABLE"