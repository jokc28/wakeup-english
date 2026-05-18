#!/usr/bin/env python3
"""Generates small WAV sound-effect files for the quiz feedback layer.

Outputs (44.1kHz 16-bit mono):
    assets/sounds/sfx/correct.wav   — ~280ms ascending arpeggio
    assets/sounds/sfx/wrong.wav     — ~300ms descending dyad
    assets/sounds/sfx/combo.wav     — ~360ms quick rising scale
    assets/sounds/sfx/complete.wav  — ~600ms fanfare

Run from repo root:
    python3 scripts/generate-sfx.py
"""

from __future__ import annotations

import math
import struct
import wave
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
OUT_DIR = REPO / "assets" / "sounds" / "sfx"
SR = 44_100  # sample rate


def _tone(freq_hz: float, dur_ms: int, gain: float = 0.6,
          attack_ms: int = 8, release_ms: int = 60) -> bytes:
    """Returns 16-bit PCM bytes for a sine tone with envelope."""
    total_samples = int(SR * dur_ms / 1000)
    attack = int(SR * attack_ms / 1000)
    release = int(SR * release_ms / 1000)
    samples = bytearray()
    for n in range(total_samples):
        t = n / SR
        if n < attack:
            env = n / max(attack, 1)
        elif n > total_samples - release:
            env = (total_samples - n) / max(release, 1)
        else:
            env = 1.0
        val = math.sin(2 * math.pi * freq_hz * t) * gain * env
        samples.extend(struct.pack("<h", int(val * 32_767)))
    return bytes(samples)


def _silence(dur_ms: int) -> bytes:
    n = int(SR * dur_ms / 1000)
    return b"\x00\x00" * n


def _write_wav(path: Path, pcm: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(pcm)


def correct_sfx() -> bytes:
    # C5 (523.25) → E5 (659.25) → G5 (783.99), staccato arpeggio
    return (
        _tone(523.25, 80, gain=0.55)
        + _tone(659.25, 80, gain=0.55)
        + _tone(783.99, 120, gain=0.6, release_ms=80)
    )


def wrong_sfx() -> bytes:
    # E4 (329.63) → C4 (261.63), descending
    return _tone(329.63, 140, gain=0.5) + _tone(261.63, 160, gain=0.5, release_ms=70)


def combo_sfx() -> bytes:
    # Quick rising scale: C5 D5 E5 G5 C6
    return (
        _tone(523.25, 60, gain=0.5)
        + _tone(587.33, 60, gain=0.5)
        + _tone(659.25, 60, gain=0.55)
        + _tone(783.99, 70, gain=0.55)
        + _tone(1046.50, 110, gain=0.6, release_ms=80)
    )


def complete_sfx() -> bytes:
    # Mini fanfare: C5-E5-G5 chord (sequential), then C6 with longer tail
    return (
        _tone(523.25, 110, gain=0.55)
        + _tone(659.25, 110, gain=0.55)
        + _tone(783.99, 110, gain=0.55)
        + _silence(20)
        + _tone(1046.50, 240, gain=0.65, release_ms=160)
    )


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for name, fn in (
        ("correct", correct_sfx),
        ("wrong", wrong_sfx),
        ("combo", combo_sfx),
        ("complete", complete_sfx),
    ):
        path = OUT_DIR / f"{name}.wav"
        _write_wav(path, fn())
        print(f"Wrote {path} ({path.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
