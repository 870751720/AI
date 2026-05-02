---
name: game-asset-finder
description: Discover and index game art/audio assets from an external art library without copying them into the project. Use when the user needs to (1) find, search, or locate game assets (images, audio, fonts, animations), (2) discover what resources are available in the art library, (3) get recommendations for which assets to use for a specific purpose, (4) plan asset imports before actually copying files, or (5) query the external asset library at C:\Users\Gavin\Desktop\美术库.
---

# Game Asset Finder

Discover assets in the external art library `C:\Users\Gavin\Desktop\美术库` and recommend how to use them in the Phaser game project.

## Core Workflow

When triggered, follow these steps:

1. **Clarify the need** — What type of asset does the user want? (character, environment, UI, icon, audio/sfx, font, farm-RPG, or misc)
2. **Scan the library** — Run `scripts/scan-assets.ps1` with appropriate `-Type` and/or `-Keyword` filters.
3. **Report findings** — Summarize what was found, with file paths and brief descriptions.
4. **Recommend import path** — Map discovered assets to the project's `public/assets/` directory structure.

## Scan Script Usage

```powershell
# List top-level categories
.\scripts\scan-assets.ps1 -ListCategories

# Search by category + keyword
.\scripts\scan-assets.ps1 -Type character -Keyword "Walking"
.\scripts\scan-assets.ps1 -Type audio -Keyword "sword" -Limit 20

# Search across entire library
.\scripts\scan-assets.ps1 -Keyword "Idle"
```

**Valid `-Type` values:** `character`, `environment`, `icon`, `ui`, `font`, `audio`, `farm`, `misc`

## Asset Categories & Import Mapping

| Source Dir | Asset Type | Target `public/assets/` Path |
|------------|-----------|------------------------------|
| `character/PNG/**` | Character animations | `images/characters/` |
| `environment/PNG/**` | Scenery, buildings, tiles | `images/environment/` |
| `icon/Background/**` | UI backgrounds | `images/ui/backgrounds/` |
| `素材/Icons 2D/**` | Item/skill icons | `images/icons/` |
| `Unity2DRPG_Farm_Assets-main/Sprites/**` | Farm RPG sprites | `images/farm/` |
| `Unity2DRPG_Farm_Assets-main/Sounds/**` | Farm RPG audio | `audio/` (bgm/ sfx/) |
| `音效库/**` | Sound effects | `audio/sfx/` |
| `font/*.ttf` | Fonts | `fonts/` |

> See `references/library-structure.md` for detailed breakdowns of each category, frame counts, and subdirectories.

## Reporting Format

Present results in this order:

1. **What was searched** (type + keyword)
2. **Matching assets** (table or list with relative paths)
3. **Recommended import paths** (where they'd go in `public/assets/`)
4. **Suggested next step** (copy now, or continue searching)

## Important Rules

- **Never copy files unless the user explicitly says "搬运" / "复制" / "copy" / "import".**
- The art library stays external; only report and recommend.
- If the user asks for a specific animation (e.g. "主角攻击动画"), prefer `character/PNG/Barbarian 01/PNG Sequences/Attacking/`.
- If the user asks for tileable ground, point to `environment/PNG/Ground Tiles/`.
- If scan returns too many results, narrow by `-Type` or ask the user to refine keywords.
