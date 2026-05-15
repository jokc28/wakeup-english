#!/usr/bin/env python3
"""Generates the Play Store feature graphic (1024x500) for 옥모닝.

The artwork is built from the existing app icon plus brand color stripes
and Korean copy. Run from repo root:

    python3 scripts/generate-feature-graphic.py
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

REPO = Path(__file__).resolve().parents[1]
ICON_PATH = REPO / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset" / "Icon-App-1024x1024@1x.png"
OUT_DIR = REPO / "dist"
OUT_PATH = OUT_DIR / "feature-graphic.png"

WIDTH, HEIGHT = 1024, 500

# Brand palette pulled from app/screenshots: warm orange + cream background
BACKGROUND_TOP = (255, 248, 232)  # soft cream
BACKGROUND_BOTTOM = (255, 232, 199)  # warm peach
ACCENT_ORANGE = (245, 158, 11)
TEXT_DARK = (47, 32, 12)
TEXT_MUTED = (110, 80, 30)

KOREAN_FONT = "/System/Library/Fonts/AppleSDGothicNeo.ttc"

TITLE = "옥모닝"
SUBTITLE = "영어 퀴즈로 깨우는 아침 알람"
TAGLINE = "단어 정렬 · 받아쓰기 · 말하기 미션"


def vertical_gradient(width: int, height: int, top: tuple[int, int, int], bottom: tuple[int, int, int]) -> Image.Image:
    img = Image.new("RGB", (width, height), top)
    pixels = img.load()
    for y in range(height):
        t = y / max(height - 1, 1)
        r = int(top[0] + (bottom[0] - top[0]) * t)
        g = int(top[1] + (bottom[1] - top[1]) * t)
        b = int(top[2] + (bottom[2] - top[2]) * t)
        for x in range(width):
            pixels[x, y] = (r, g, b)
    return img


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)

    canvas = vertical_gradient(WIDTH, HEIGHT, BACKGROUND_TOP, BACKGROUND_BOTTOM)
    draw = ImageDraw.Draw(canvas)

    # Accent orange stripe along the bottom edge
    draw.rectangle((0, HEIGHT - 12, WIDTH, HEIGHT), fill=ACCENT_ORANGE)

    # Place the app icon on the left
    icon = Image.open(ICON_PATH).convert("RGBA")
    icon_size = 360
    icon = icon.resize((icon_size, icon_size), Image.LANCZOS)
    icon_x = 64
    icon_y = (HEIGHT - icon_size) // 2
    canvas.paste(icon, (icon_x, icon_y), icon)

    # Right-hand text block
    title_font = ImageFont.truetype(KOREAN_FONT, 120, index=1)  # Bold
    subtitle_font = ImageFont.truetype(KOREAN_FONT, 44, index=0)
    tagline_font = ImageFont.truetype(KOREAN_FONT, 30, index=0)

    text_x = icon_x + icon_size + 56
    draw.text((text_x, 130), TITLE, fill=TEXT_DARK, font=title_font)
    draw.text((text_x, 280), SUBTITLE, fill=TEXT_DARK, font=subtitle_font)
    draw.text((text_x, 348), TAGLINE, fill=TEXT_MUTED, font=tagline_font)

    canvas.save(OUT_PATH, "PNG", optimize=True)
    print(f"Wrote {OUT_PATH} ({OUT_PATH.stat().st_size // 1024} KB, {WIDTH}x{HEIGHT})")


if __name__ == "__main__":
    main()
