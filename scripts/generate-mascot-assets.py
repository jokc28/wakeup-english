#!/usr/bin/env python3
"""Generate Sunny mascot SVG + PNG assets for 옥모닝.

Outputs:
    sunny-{state}.svg            (5 files: smile, wink, sad, sleepy, excited)
    sunny-{state}@{1,2,3}x.png   (15 files)
"""

from __future__ import annotations

import argparse
import subprocess
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
DEFAULT_OUT = REPO / "assets" / "mascot"

COLOR_BODY = "#FF6B1A"
COLOR_BODY_SAD = "#D9663F"
COLOR_BODY_SLEEPY = "#E8A14F"
COLOR_HIGHLIGHT = "#FFE066"
COLOR_FACE_DETAIL = "#1F1108"
COLOR_BLUSH = "#FFAB7E"
COLOR_TEAR = "#4FA5D4"
COLOR_RAY_DIM = "#C9923B"
COLOR_RAY_SAD = "#B85C42"


def svg_for(state: str) -> str:
    common_defs = (
        f'<defs><radialGradient id="g" cx="0.3" cy="0.3">'
        f'<stop offset="0" stop-color="{COLOR_HIGHLIGHT}"/>'
        f'<stop offset="1" stop-color="{COLOR_BODY}"/>'
        f'</radialGradient></defs>'
    )
    if state == "smile":
        return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
{common_defs}
<g stroke="{COLOR_BODY}" stroke-width="6" stroke-linecap="round">
  <line x1="60" y1="6" x2="60" y2="18"/><line x1="60" y1="102" x2="60" y2="114"/>
  <line x1="6" y1="60" x2="18" y2="60"/><line x1="102" y1="60" x2="114" y2="60"/>
  <line x1="22" y1="22" x2="30" y2="30"/><line x1="90" y1="30" x2="98" y2="22"/>
  <line x1="22" y1="98" x2="30" y2="90"/><line x1="90" y1="90" x2="98" y2="98"/>
</g>
<circle cx="60" cy="60" r="34" fill="{COLOR_BODY}"/>
<circle cx="60" cy="60" r="34" fill="url(#g)" opacity="0.4"/>
<circle cx="50" cy="56" r="4" fill="{COLOR_FACE_DETAIL}"/>
<circle cx="70" cy="56" r="4" fill="{COLOR_FACE_DETAIL}"/>
<path d="M48 68 Q60 78 72 68" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<ellipse cx="44" cy="66" rx="4" ry="2.5" fill="{COLOR_BLUSH}" opacity="0.85"/>
<ellipse cx="76" cy="66" rx="4" ry="2.5" fill="{COLOR_BLUSH}" opacity="0.85"/>
</svg>'''
    if state == "wink":
        return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
{common_defs}
<g stroke="{COLOR_BODY}" stroke-width="6" stroke-linecap="round">
  <line x1="60" y1="6" x2="60" y2="18"/><line x1="60" y1="102" x2="60" y2="114"/>
  <line x1="6" y1="60" x2="18" y2="60"/><line x1="102" y1="60" x2="114" y2="60"/>
  <line x1="22" y1="22" x2="30" y2="30"/><line x1="90" y1="30" x2="98" y2="22"/>
  <line x1="22" y1="98" x2="30" y2="90"/><line x1="90" y1="90" x2="98" y2="98"/>
</g>
<circle cx="60" cy="60" r="34" fill="{COLOR_BODY}"/>
<circle cx="60" cy="60" r="34" fill="url(#g)" opacity="0.4"/>
<path d="M44 56 Q50 50 56 56" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<circle cx="70" cy="56" r="4" fill="{COLOR_FACE_DETAIL}"/>
<path d="M48 68 Q60 80 72 68" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<ellipse cx="44" cy="66" rx="4" ry="2.5" fill="{COLOR_BLUSH}" opacity="0.85"/>
<ellipse cx="76" cy="66" rx="4" ry="2.5" fill="{COLOR_BLUSH}" opacity="0.85"/>
</svg>'''
    if state == "sad":
        return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
<defs><radialGradient id="gs" cx="0.3" cy="0.3"><stop offset="0" stop-color="#FFC58A"/><stop offset="1" stop-color="{COLOR_BODY_SAD}"/></radialGradient></defs>
<g stroke="{COLOR_RAY_SAD}" stroke-width="6" stroke-linecap="round" opacity="0.7">
  <line x1="60" y1="14" x2="60" y2="20"/>
  <line x1="14" y1="60" x2="20" y2="60"/>
  <line x1="100" y1="60" x2="106" y2="60"/>
</g>
<circle cx="60" cy="60" r="34" fill="{COLOR_BODY_SAD}"/>
<circle cx="60" cy="60" r="34" fill="url(#gs)" opacity="0.35"/>
<path d="M44 58 Q50 54 56 58" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<path d="M64 58 Q70 54 76 58" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<path d="M48 74 Q60 64 72 74" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<ellipse cx="46" cy="66" rx="3.5" ry="2" fill="{COLOR_BLUSH}" opacity="0.6"/>
<ellipse cx="74" cy="66" rx="3.5" ry="2" fill="{COLOR_BLUSH}" opacity="0.6"/>
<path d="M51 62 L49 70" stroke="{COLOR_TEAR}" stroke-width="2.5" fill="none" stroke-linecap="round"/>
<circle cx="49" cy="71" r="2" fill="{COLOR_TEAR}"/>
</svg>'''
    if state == "sleepy":
        return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
<defs><radialGradient id="gz" cx="0.3" cy="0.3"><stop offset="0" stop-color="#FFD89B"/><stop offset="1" stop-color="{COLOR_BODY_SLEEPY}"/></radialGradient></defs>
<g stroke="{COLOR_RAY_DIM}" stroke-width="6" stroke-linecap="round" opacity="0.5">
  <line x1="60" y1="14" x2="60" y2="22"/>
  <line x1="14" y1="60" x2="22" y2="60"/>
  <line x1="98" y1="60" x2="106" y2="60"/>
</g>
<circle cx="60" cy="60" r="34" fill="{COLOR_BODY_SLEEPY}"/>
<circle cx="60" cy="60" r="34" fill="url(#gz)" opacity="0.3"/>
<path d="M44 58 Q50 62 56 58" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<path d="M64 58 Q70 62 76 58" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round"/>
<ellipse cx="60" cy="70" rx="6" ry="3" fill="{COLOR_FACE_DETAIL}"/>
<text x="78" y="42" font-size="20" fill="{COLOR_FACE_DETAIL}" opacity="0.6">z</text>
<text x="86" y="32" font-size="14" fill="{COLOR_FACE_DETAIL}" opacity="0.5">z</text>
</svg>'''
    if state == "excited":
        return f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
{common_defs}
<g stroke="{COLOR_BODY}" stroke-width="7" stroke-linecap="round">
  <line x1="60" y1="2" x2="60" y2="18"/><line x1="60" y1="102" x2="60" y2="118"/>
  <line x1="2" y1="60" x2="18" y2="60"/><line x1="102" y1="60" x2="118" y2="60"/>
  <line x1="18" y1="18" x2="28" y2="28"/><line x1="92" y1="28" x2="102" y2="18"/>
  <line x1="18" y1="102" x2="28" y2="92"/><line x1="92" y1="92" x2="102" y2="102"/>
</g>
<circle cx="60" cy="60" r="34" fill="{COLOR_BODY}"/>
<circle cx="60" cy="60" r="34" fill="url(#g)" opacity="0.4"/>
<path d="M46 52 L54 60 L46 56" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M74 52 L66 60 L74 56" stroke="{COLOR_FACE_DETAIL}" stroke-width="3.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M44 65 Q60 84 76 65 Q60 75 44 65" fill="{COLOR_FACE_DETAIL}"/>
<path d="M48 67 Q60 80 72 67" fill="white"/>
<ellipse cx="42" cy="68" rx="4" ry="2.5" fill="{COLOR_BLUSH}"/>
<ellipse cx="78" cy="68" rx="4" ry="2.5" fill="{COLOR_BLUSH}"/>
<circle cx="36" cy="36" r="2" fill="{COLOR_HIGHLIGHT}"/>
<circle cx="86" cy="42" r="2" fill="{COLOR_HIGHLIGHT}"/>
</svg>'''
    raise ValueError(f"unknown state: {state}")


def svg_to_png(svg_path: Path, png_path: Path, target_px: int) -> None:
    subprocess.run(
        ["rsvg-convert", "-w", str(target_px), "-h", str(target_px),
         "-o", str(png_path), str(svg_path)],
        check=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--out-dir", default=str(DEFAULT_OUT))
    parser.add_argument("--dpi", type=int, choices=[1, 2, 3])
    args = parser.parse_args()

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    base_px = 120
    dpis = [args.dpi] if args.dpi else [1, 2, 3]

    for state in ("smile", "wink", "sad", "sleepy", "excited"):
        svg_path = out_dir / f"sunny-{state}.svg"
        svg_path.write_text(svg_for(state), encoding="utf-8")
        for dpi in dpis:
            png_path = out_dir / f"sunny-{state}@{dpi}x.png"
            svg_to_png(svg_path, png_path, base_px * dpi)

    print(f"Wrote SVG + PNG assets to {out_dir}")


if __name__ == "__main__":
    main()
