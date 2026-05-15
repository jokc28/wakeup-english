#!/usr/bin/env bash
# Drives the app through 4 key screens and saves Play/App Store screenshots.
#
# Prereqs:
#   - An emulator or physical device running and listed by `flutter devices`.
#     Recommended for Play Store: Pixel 7 emulator (1080×2400, API 34+).
#   - flutter pub get already run.

set -euo pipefail

OUT_DIR="build/store-screenshots"
mkdir -p "${OUT_DIR}"

DEVICE_ID="${1:-}"
if [[ -z "${DEVICE_ID}" ]]; then
  echo "Usage: ./scripts/capture-screenshots.sh <device-id>"
  echo "Available devices:"
  flutter devices
  exit 1
fi

flutter test integration_test/store_screenshots_test.dart \
  --device-id "${DEVICE_ID}" \
  --reporter expanded

# integration_test saves screenshots under build/integration_response_data/
# (Android) or as XCTest attachments (iOS). Surface them in a unified folder.
if [[ -d build/integration_response_data ]]; then
  cp build/integration_response_data/*.png "${OUT_DIR}/" 2>/dev/null || true
fi

echo
echo "Screenshots saved to: ${OUT_DIR}/"
ls -la "${OUT_DIR}/" 2>/dev/null || true
