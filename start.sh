#!/bin/sh

# Natychmiast zakończ skrypt, jeśli którekolwiek polecenie zwróci błąd
set -e

echo "--- Uruchamianie skryptu startowego KDB.AI ---"

# --- Walidacja zmiennych ---
if [ -z "$KDB_LICENSE_B64" ]; then
    echo "[BŁĄD] Zmienna środowiskowa KDB_LICENSE_B64 nie jest ustawiona!"
    exit 1
fi

if [ -z "$THREADS" ]; then
    echo "[OSTRZEŻENIE] Zmienna THREADS nie jest ustawiona. Używam domyślnie 1 rdzenia."
    THREADS=1
fi

# --- Logika licencji ---
echo "Tworzenie pliku licencji w /tmp/kc.lic..."
# Użycie opcji -d dla `echo`, aby uniknąć problemów z interpretacją znaków specjalnych
echo -n "$KDB_LICENSE_B64" | base64 -d > /tmp/kc.lic
export QLIC=/tmp

echo "Plik licencji utworzony."

# --- Uruchomienie aplikacji ---
# Obliczenie zakresu dla taskset, np. dla THREADS=8 będzie to "0-7"
CORE_RANGE="0-$(($THREADS-1))"
EXECUTABLE="/opt/kx/bin/kdbai-db"

echo "Sprawdzanie pliku wykonywalnego: $EXECUTABLE"
if [ ! -x "$EXECUTABLE" ]; then
    echo "[BŁĄD] Plik wykonywalny $EXECUTABLE nie istnieje lub nie ma uprawnień do wykonania!"
    exit 1
fi

echo "Uruchamianie procesu KDB.AI na rdzeniach: $CORE_RANGE"
# Użyj 'exec', aby proces docelowy zastąpił proces powłoki
# To jest kluczowe dla prawidłowego działania w kontenerach
exec taskset -c "$CORE_RANGE" "$EXECUTABLE"