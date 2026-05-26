#!/usr/bin/env python3
"""Upload a release AAB to a Google Play track via the Play Developer API.

Uses the RevenueCat service account JSON (already granted "Manage orders"
+ release permissions in Play Console). Note: freshly-granted service
account permissions can take time to propagate — a 401/403 here means
"try again later", not a config error.

Usage:
    python3 scripts/upload-aab-to-play.py \
        --json ~/Downloads/okmorning-revenuecat-XXXX.json \
        --aab build/app/outputs/bundle/release/app-release.aab \
        --package com.wakeup.english.wakeup_english \
        --track internal
"""

from __future__ import annotations

import argparse
import sys

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload

SCOPES = ["https://www.googleapis.com/auth/androidpublisher"]


def main() -> int:
    p = argparse.ArgumentParser()
    p.add_argument("--json", required=True, help="service account JSON path")
    p.add_argument("--aab", required=True, help="path to app-release.aab")
    p.add_argument("--package", required=True, help="app package name")
    p.add_argument("--track", default="internal",
                   help="internal | alpha | beta | production")
    p.add_argument("--notes", default="옥모닝 업데이트 — 게이미피케이션 + 실제 구독 연결",
                   help="release notes (ko-KR)")
    args = p.parse_args()

    creds = service_account.Credentials.from_service_account_file(
        args.json, scopes=SCOPES)
    service = build("androidpublisher", "v3", credentials=creds,
                    cache_discovery=False)

    pkg = args.package
    print(f"Creating edit for {pkg} ...")
    edit = service.edits().insert(packageName=pkg, body={}).execute()
    edit_id = edit["id"]
    print(f"  edit id: {edit_id}")

    print(f"Uploading AAB: {args.aab} ...")
    media = MediaFileUpload(args.aab,
                            mimetype="application/octet-stream",
                            resumable=True)
    bundle = service.edits().bundles().upload(
        packageName=pkg, editId=edit_id, media_body=media).execute()
    version_code = bundle["versionCode"]
    print(f"  uploaded versionCode: {version_code}")

    print(f"Assigning versionCode {version_code} to track '{args.track}' ...")
    service.edits().tracks().update(
        packageName=pkg, editId=edit_id, track=args.track,
        body={
            "track": args.track,
            "releases": [{
                "status": "completed",
                "versionCodes": [str(version_code)],
                "releaseNotes": [{
                    "language": "ko-KR",
                    "text": args.notes,
                }],
            }],
        }).execute()

    print("Committing edit ...")
    service.edits().commit(packageName=pkg, editId=edit_id).execute()
    print(f"✓ Done. versionCode {version_code} live on '{args.track}' track.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
