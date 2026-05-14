# LEAP Design Tokens

This document explains every visual decision in `style.css` so you can customize without breaking ATS-friendliness or single-page fit.

---

## Color palette

| Token | Hex | Where it appears | Why this color |
|---|---|---|---|
| `--accent` | `#1F3A5F` | Name, section headers, header divider | Deep navy — reads as "corporate / professional" without being black. Survives B&W printing. |
| `--accent-soft` | `#345783` | Tagline, bullet markers, `<strong>` in info lists | A softer navy that pairs with `--accent` without being indistinguishable. |
| `--ink` | `#1F2937` | Body text | Near-black, not pure black — easier on the eye, still high contrast. |
| `--muted` | `#5B6473` | Dates, titles under company name | Grey-blue — visually demotes secondary metadata so bullets pop. |
| `--rule` | `#D8DEE7` | Section dividers (h2 underline) | Very light grey — divides without shouting. |

### Customizing the palette
Swap `--accent` to align with a target brand if you want a thematic CV (e.g., a green for a sustainability-tech role). **Keep the contrast ratio above 4.5:1** so it remains legible. Don't change `--ink` — body text needs to be near-black for both legibility and ATS parsers.

---

## Typography

| Element | Font | Size | Weight | Why |
|---|---|---|---|---|
| Name | `Playfair Display` (Google Fonts) | 26pt | 700 | Serif display font — gives the masthead a "publication" feel without going corporate-overdone. |
| Tagline (role under name) | `Inter` | 10.5pt | 500 | Sans-serif body face, all-caps with `letter-spacing: 1.5pt` for elegance. |
| Contact line | `Inter` | 9.7pt | 400 | Smaller than body to demote metadata. |
| Body text | `Inter` | 10.2pt | 400 | Inter is engineered for screen + print clarity. Calibri fallback if Inter is unavailable. |
| h2 (section headers) | `Inter` | 10.8pt | 700, all-caps, `letter-spacing: 1.8pt` | Distinctive without screaming. |
| Company / Institution name | `Inter` | 10.8pt | 600 | Slightly bolder than body to anchor each role visually. |
| Bullet text | `Inter` | 10.2pt | 400 | Same as body for consistency. |

### Why these fonts are safe for ATS
ATS parsers extract text from the underlying PDF text layer. As long as the PDF has a text layer (LEAP's render pipeline guarantees this), the parser doesn't care which font is used to *display* the text. Custom fonts are fine.

### Font fallbacks
The CSS provides explicit fallback chains:
- `Inter` → `Calibri` → `Helvetica Neue` → `Arial` → `sans-serif`
- `Playfair Display` → `Georgia` → `Times New Roman` → `serif`

If Google Fonts can't load (offline environment), the CV still renders cleanly with system fonts.

---

## Spacing system

LEAP uses **points (pt)** throughout rather than pixels or rems. Reason: PDF is the final form; pt maps directly to physical print units.

| Element | Margin / spacing | Why |
|---|---|---|
| Page margin | `0.45in × 0.55in` | Tight enough to fit content; wide enough to look intentional. Standard ATS-friendly range is 0.4–0.7in. |
| Body line-height | `1.24` | Tight but legible. The bullets justify, so this needs to be tight enough to avoid stretched-word artifacts. |
| h2 margin | `5pt 0 2pt 0` | Just enough vertical breathing room between sections. |
| Bullet `<li>` margin | `0 0 0.9pt 0` | Almost no gap between bullets — relies on line-height for separation. |
| Header `gap` (photo ↔ text) | `15pt` | Visual breathing room between photo and name. |

### Single-page fit
The CSS is tuned to fit:
- 6 bullets at the current/most-recent role
- 2 bullets at each previous role (typically 2–3 previous roles)
- 1 line at Education
- 3 lines at Skills
- 3 lines at Additional Information

If you overflow to a second page, your options in order of preference:
1. **Cut bullets** — usually the right answer. Re-rank by impact and trim from the bottom.
2. **Reduce `font-size`** by 0.1pt (e.g., 10.2 → 10.1).
3. **Reduce `line-height`** by 0.02 (e.g., 1.24 → 1.22).
4. **Reduce h2 `margin-top`** to 4pt or 3pt.
5. **Reduce `@page margin`** to 0.42in × 0.5in.

Don't go below 9.8pt body or 1.2 line-height — readability craters.

---

## Photo styling

| Property | Value | Why |
|---|---|---|
| Size | `88pt × 108pt` | ~3:4 portrait aspect, fits without dominating the masthead. |
| `object-fit` | `cover` | Crops the source image to fit the box without distortion. |
| `object-position` | `center 18%` | Anchors the crop on the upper portion — face stays in frame even if source photo has a wide background. |
| `border-radius` | `4pt` | Subtle rounded corners — not "iOS-app" round. |
| `box-shadow` | `0 1pt 4pt rgba(31, 58, 95, 0.18)` | A whisper of shadow that says "yes I have a photo" without screaming "Wordpress 2014". |

### Photo recommendations
- **Resolution**: source 600px wide minimum.
- **Crop**: shoulders-up, face occupying ~50% of frame height.
- **Background**: neutral / out-of-focus.
- **Format**: JPEG, quality 85–90, file size ~80–150 KB.
- **Naming**: save as `profile.jpg` at `outputs/_shared/profile.jpg`.

### When NOT to include a photo
- Application portals in the US for many roles (some hiring guidance recommends omitting to avoid bias).
- ATS-strict portals where you want to minimize parsing risk.

To generate a no-photo variant, edit the variant's HTML and replace the `<img class="photo">` with nothing, or remove the entire `<header>` photo flex column.

---

## Bullet semantics (critical for ATS)

LEAP uses **standard `<ul><li>` markup with `list-style: disc`** and styles the `::marker` pseudo-element for color customization.

Why this matters: an earlier version used `list-style: none` with `::before` pseudo-elements for custom bullets. That broke PDF text-extraction order — bullets appeared *after* all the section text in the parsed output, scrambling the reading flow for ATS.

The current approach (default disc bullets, recolored via `::marker`) keeps the visual customization AND the semantic reading order intact. **Do not change this.**

---

## Justification

Bullet text uses `text-align: justify; text-justify: inter-word`. This gives the CV a clean right edge that reads as polished.

Skills and Additional Information bullets use `text-align: left` because they contain short labeled lines where justification would create awkward gaps.

---

## Customization safe-list

You can change these without breaking anything:
- All five color tokens (`--accent`, `--accent-soft`, `--ink`, `--muted`, `--rule`)
- Photo `border-radius` (0 for square; up to 50% for circle — though circle requires changing `height` to match `width`)
- Photo `box-shadow` (remove it entirely if you want a flatter look)
- Font choice (swap `Playfair Display` for any other serif display font from Google Fonts)
- h2 `letter-spacing` (lower it for less "designed" feel)

Don't change these without testing single-page fit and ATS extraction:
- Font sizes (any of them)
- Line-height
- Page margins
- The `<ul>` / `<li>` / `::marker` structure
- The `<header>` flex layout (works with `display: flex`; switching to `grid` or `table` may break ATS)
