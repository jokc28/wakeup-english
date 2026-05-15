#!/usr/bin/env bash
# Builds the App Store-ready iOS .ipa for 옥모닝.
# Requires:
#   - Xcode + active Apple Developer Program membership for team 68ZV6L82DK
#   - REVENUECAT_IOS_API_KEY exported (real appl_ key, NOT appl_YOUR_...)
#   - CocoaPods installed (`brew install cocoapods` or `sudo gem install cocoapods`)
#
# Uploads are NOT automated. Use Transporter or Xcode Organizer to push the
# generated .ipa to App Store Connect.

set -euo pipefail

if [[ -z "${REVENUECAT_IOS_API_KEY:-}" ]]; then
  echo "ERROR: REVENUECAT_IOS_API_KEY is not set."
  echo "       export REVENUECAT_IOS_API_KEY=appl_real_key_here"
  exit 1
fi

if [[ "${REVENUECAT_IOS_API_KEY}" == appl_YOUR_* ]]; then
  echo "ERROR: REVENUECAT_IOS_API_KEY is still a placeholder."
  exit 1
fi

# Intentionally no `flutter clean` — it deletes build/ globally, which would
# wipe an AAB sitting in build/app/outputs/bundle/release/ from a previous run.
flutter pub get
(cd ios && pod install --repo-update)

flutter build ipa --release \
  --dart-define=REVENUECAT_IOS_API_KEY="${REVENUECAT_IOS_API_KEY}" \
  --export-method app-store

echo
echo "IPA ready at: build/ios/ipa/"
echo "Next: open Transporter.app or run \`xcrun altool --upload-app -f build/ios/ipa/*.ipa --apiKey <key_id> --apiIssuer <issuer_id>\`"
echo "Then promote the build to TestFlight Internal Testing before submitting for review."
