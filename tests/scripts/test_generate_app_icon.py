"""Verifies generate-app-icon.py emits a 1024 master and a 512 Play icon."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SCRIPT = REPO / "scripts" / "generate-app-icon.py"


def test_master_and_play_icon_emitted(tmp_path):
    result = subprocess.run(
        [sys.executable, str(SCRIPT),
         "--out-master", str(tmp_path / "master.png"),
         "--out-play",  str(tmp_path / "play-512.png"),
         "--skip-platforms"],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, result.stderr
    master = tmp_path / "master.png"
    play = tmp_path / "play-512.png"
    assert master.exists() and master.stat().st_size > 10_000
    assert play.exists() and play.stat().st_size > 5_000

    from PIL import Image
    with Image.open(master) as im:
        assert im.size == (1024, 1024)
    with Image.open(play) as im:
        assert im.size == (512, 512)
