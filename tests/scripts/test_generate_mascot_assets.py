"""Verifies generate-mascot-assets.py produces the expected 5 SVG + 15 PNG files."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
SCRIPT = REPO_ROOT / "scripts" / "generate-mascot-assets.py"

STATES = ["smile", "wink", "sad", "sleepy", "excited"]


def test_script_exists():
    assert SCRIPT.exists(), f"missing {SCRIPT}"


def test_script_runs_and_emits_all_files(tmp_path):
    result = subprocess.run(
        [sys.executable, str(SCRIPT), "--out-dir", str(tmp_path)],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, result.stderr

    for state in STATES:
        svg = tmp_path / f"sunny-{state}.svg"
        assert svg.exists() and svg.stat().st_size > 200, f"missing or empty {svg}"
        for dpi in (1, 2, 3):
            png = tmp_path / f"sunny-{state}@{dpi}x.png"
            assert png.exists() and png.stat().st_size > 500, f"missing or small {png}"
