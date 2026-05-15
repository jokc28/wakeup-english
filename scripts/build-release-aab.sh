#!/usr/bin/env bash
# Builds the Play-ready Android App Bundle for 옥모닝.
# Requires:
#   - android/key.properties present and populated
#   - REVENUECAT_ANDROID_API_KEY exported in the shell (real key, NOT goog_YOUR_...)

set -euo pipefail

if [[ -z "${REVENUECAT_ANDROID_API_KEY:-}" ]]; then
  echo "ERROR: REVENUECAT_ANDROID_API_KEY is not set."
  echo "       export REVENUECAT_ANDROID_API_KEY=goog_real_key_here"
  exit 1
fi

if [[ "${REVENUECAT_ANDROID_API_KEY}" == goog_YOUR_* ]]; then
  echo "ERROR: REVENUECAT_ANDROID_API_KEY is still a placeholder."
  exit 1
fi

if [[ ! -f android/key.properties ]]; then
  echo "ERROR: android/key.properties missing. Run scripts/generate-upload-keystore.sh first."
  exit 1
fi

flutter clean
flutter pub get
flutter build appbundle --release \
  --dart-define=REVENUECAT_ANDROID_API_KEY="${REVENUECAT_ANDROID_API_KEY}"

echo
echo "AAB ready at: build/app/outputs/bundle/release/app-release.aab"
echo "Upload to Play Console → Internal testing track first."
