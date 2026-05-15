#!/usr/bin/env bash
# Generates the Google Play upload keystore for 옥모닝 (wakeup_english).
# Run this ONCE on a machine you control. The resulting .jks must be backed up
# securely — losing it means you can no longer publish updates under the same
# applicationId on Google Play.

set -euo pipefail

KEYSTORE_DIR="${HOME}/.android-keystores/wakeup-english"
KEYSTORE_PATH="${KEYSTORE_DIR}/upload-keystore.jks"
KEY_ALIAS="upload"

mkdir -p "${KEYSTORE_DIR}"

if [[ -f "${KEYSTORE_PATH}" ]]; then
  echo "ERROR: ${KEYSTORE_PATH} already exists. Refusing to overwrite."
  exit 1
fi

echo "About to generate upload keystore at: ${KEYSTORE_PATH}"
echo "keytool will prompt for store password, key password, and distinguished name."
echo

keytool -genkey -v \
  -keystore "${KEYSTORE_PATH}" \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias "${KEY_ALIAS}"

echo
echo "Keystore created."
echo "Next: copy android/key.properties.example to android/key.properties and fill in:"
echo "  storePassword=<the store password you just entered>"
echo "  keyPassword=<the key password you just entered>"
echo "  keyAlias=${KEY_ALIAS}"
echo "  storeFile=${KEYSTORE_PATH}"
echo
echo "Back up ${KEYSTORE_PATH} to a password manager / offline drive immediately."
