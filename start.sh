#!/usr/bin/env bash
# Startet die Schwarm-Oberfläche im Browser.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT="${1:-8090}"

cd "$DIR"
echo "Schwarmintelligenz läuft auf http://localhost:$PORT"
echo "Zum Beenden: Strg+C"

if command -v xdg-open >/dev/null 2>&1; then
  ( sleep 1; xdg-open "http://localhost:$PORT/index.html" >/dev/null 2>&1 || true ) &
fi

exec python3 -m http.server "$PORT" --bind 127.0.0.1
