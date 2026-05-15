#!/usr/bin/env bash
# Downloads the 5 Pretendard TTF weights we ship into assets/fonts/.
# Pretendard is OFL 1.1 — bundling and redistribution is permitted.

set -euo pipefail

VERSION="1.3.9"
BASE="https://github.com/orioncactus/pretendard/raw/v${VERSION}/packages/pretendard/dist/public/static"
OUT_DIR="assets/fonts"
mkdir -p "$OUT_DIR"

for weight in Regular Medium SemiBold Bold ExtraBold; do
  url="$BASE/Pretendard-$weight.otf"
  out="$OUT_DIR/Pretendard-$weight.ttf"
  echo "Fetching $weight..."
  curl -sSL "$url" -o "$out"
done

ls -la "$OUT_DIR"
