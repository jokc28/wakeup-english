#!/usr/bin/env bash
# Drives the app through 4 key screens and saves Play/App Store screenshots.
#
# Prereqs:
#   - An emulator or physical device running and listed by `flutter devices`.
#     Recommended for Play Store: Pixel 7 emulator (1080×2400, API 34+).
#   - flutter pub get already run.

set -euo pipefail

OUT_DIR="dist/store-screenshots"
mkdir -p "${OUT_DIR}"

DEVICE_ID="${1:-}"
if [[ -z "${DEVICE_ID}" ]]; then
  echo "Usage: ./scripts/capture-screenshots.sh <device-id>"
  echo "Available devices:"
  flutter devices
  exit 1
fi

ANDROID_KEY="${REVENUECAT_ANDROID_API_KEY:-goog_PLACEHOLDER}"
IOS_KEY="${REVENUECAT_IOS_API_KEY:-appl_PLACEHOLDER}"

flutter drive \
  --driver test_driver/integration_test.dart \
  --target integration_test/store_screenshots_test.dart \
  --device-id "${DEVICE_ID}" \
  --dart-define=REVENUECAT_ANDROID_API_KEY="${ANDROID_KEY}" \
  --dart-define=REVENUECAT_IOS_API_KEY="${IOS_KEY}"

echo
echo "Screenshots saved to: ${OUT_DIR}/"
ls -la "${OUT_DIR}/" 2>/dev/null || true
