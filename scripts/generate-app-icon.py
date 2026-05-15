#!/usr/bin/env python3
"""Generate the Sunny-centered app icon and all platform sizes."""

from __future__ import annotations

import argparse
import subprocess
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]

ICON_SVG = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">
<defs>
  <linearGradient id="bg" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0" stop-color="#FFB347"/>
    <stop offset="1" stop-color="#FF6B1A"/>
  </linearGradient>
  <radialGradient id="face" cx="0.32" cy="0.3">
    <stop offset="0" stop-color="#FFE066"/>
    <stop offset="1" stop-color="#FF8C00"/>
  </radialGradient>
</defs>
<rect width="1024" height="1024" fill="url(#bg)"/>
<g stroke="#FFE5BD" stroke-width="46" stroke-linecap="round" opacity="0.85">
  <line x1="512" y1="100" x2="512" y2="192"/>
  <line x1="512" y1="832" x2="512" y2="924"/>
  <line x1="100" y1="512" x2="192" y2="512"/>
  <line x1="832" y1="512" x2="924" y2="512"/>
  <line x1="206" y1="206" x2="266" y2="266"/>
  <line x1="758" y1="266" x2="818" y2="206"/>
  <line x1="206" y1="818" x2="266" y2="758"/>
  <line x1="758" y1="758" x2="818" y2="818"/>
</g>
<circle cx="512" cy="512" r="286" fill="url(#face)"/>
<circle cx="440" cy="480" r="33" fill="#1F1108"/>
<circle cx="584" cy="480" r="33" fill="#1F1108"/>
<path d="M420 560 Q512 632 604 560" stroke="#1F1108" stroke-width="28" fill="none" stroke-linecap="round"/>
<ellipse cx="388" cy="552" rx="36" ry="22" fill="#FFAB7E" opacity="0.85"/>
<ellipse cx="636" cy="552" rx="36" ry="22" fill="#FFAB7E" opacity="0.85"/>
</svg>"""


def render(svg_path: Path, png_path: Path, target_px: int) -> None:
    png_path.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(
        ["rsvg-convert", "-w", str(target_px), "-h", str(target_px),
         "-o", str(png_path), str(svg_path)],
        check=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--out-master", default=str(
        REPO / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset" / "Icon-App-1024x1024@1x.png"))
    parser.add_argument("--out-play", default=str(REPO / "dist" / "play-icon-512.png"))
    parser.add_argument("--skip-platforms", action="store_true")
    args = parser.parse_args()

    with tempfile.NamedTemporaryFile(suffix=".svg", delete=False) as tf:
        tf.write(ICON_SVG.encode("utf-8"))
        svg_path = Path(tf.name)

    master = Path(args.out_master)
    play = Path(args.out_play)

    render(svg_path, master, 1024)
    render(svg_path, play, 512)

    if not args.skip_platforms:
        ios_dir = REPO / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
        ios_sizes = {
            "Icon-App-20x20@1x.png": 20,  "Icon-App-20x20@2x.png": 40,  "Icon-App-20x20@3x.png": 60,
            "Icon-App-29x29@1x.png": 29,  "Icon-App-29x29@2x.png": 58,  "Icon-App-29x29@3x.png": 87,
            "Icon-App-40x40@1x.png": 40,  "Icon-App-40x40@2x.png": 80,  "Icon-App-40x40@3x.png": 120,
            "Icon-App-60x60@2x.png": 120, "Icon-App-60x60@3x.png": 180,
            "Icon-App-76x76@1x.png": 76,  "Icon-App-76x76@2x.png": 152,
            "Icon-App-83.5x83.5@2x.png": 167,
        }
        for name, px in ios_sizes.items():
            render(svg_path, ios_dir / name, px)

        android_sizes = {
            "mipmap-mdpi": 48, "mipmap-hdpi": 72, "mipmap-xhdpi": 96,
            "mipmap-xxhdpi": 144, "mipmap-xxxhdpi": 192,
        }
        for folder, px in android_sizes.items():
            target = REPO / "android" / "app" / "src" / "main" / "res" / folder / "ic_launcher.png"
            render(svg_path, target, px)

    svg_path.unlink()
    print(f"Master: {master}")
    print(f"Play:   {play}")
    if not args.skip_platforms:
        print("iOS density set and Android mipmaps regenerated in place.")


if __name__ == "__main__":
    main()
