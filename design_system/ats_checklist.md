# ATS Checklist

Run through this list before you submit any CV variant to a portal. Most checks take 30 seconds.

---

## 1. Text-layer check (mandatory)

```bash
pdftotext outputs/<Company>/CV_<Company>_<Role>.pdf -
```

You should see your full CV content as clean text in the correct reading order:
- Name first
- Tagline second
- Contact line third
- Then sections in order: Professional Experience → Education → Skills → Additional Information
- Within each section: company, then title+dates, then bullets in order

**Red flags:**
- Empty output → PDF is image-only (a scan or screenshot). LEAP never produces these; if you see this, something went wrong with rendering.
- Garbled text → font embedding broke. Re-render with `./outputs/_shared/render.sh build <Company> <Role>`.
- Bullets appearing before section headers → reading order broken. Check that the HTML uses `list-style: disc` + `::marker` styling, NOT `list-style: none` with `::before` pseudo-elements.
- Photo `alt` text appearing in the output → fine, ATS just sees "Rose Landeira" or whatever you set as `alt`.

---

## 2. Single-page check

```bash
./outputs/_shared/render.sh status
```

Every active variant should show `1` page. If `⚠ MULTI-PAGE` appears, trim before submitting.

---

## 3. File size check

Target: **150–400 KB** for the photo-embedded variant.

- Below 100 KB: probably image compression got too aggressive; verify the photo still looks crisp at full size.
- Above 500 KB: photo is too high-resolution; downsize to ~600px wide JPEG quality 85.

Some legacy ATS systems reject files over 2 MB. LEAP outputs are always well under that.

---

## 4. Filename check

Naming convention: `CV_<Company>_<Role>.pdf` (e.g., `CV_Google_BPM-LATAM.pdf`).

For some portals (especially older ones), prepend your last name: `LastName_CV_<Company>_<Role>.pdf`.

Avoid spaces in the filename. Use hyphens or underscores only.

---

## 5. Content checks

- [ ] **Phone number is correct** and starts with country code (`+55 …` for Brazil).
- [ ] **Email is professional** (not your university email if it's about to expire).
- [ ] **LinkedIn URL is full and correct** (`https://www.linkedin.com/in/yourhandle`, not just `linkedin.com/in/...`).
- [ ] **No literal client names** unless publicly disclosed. Search the PDF text:
   ```bash
   pdftotext outputs/Vanilla/CV.pdf - | grep -iE 'itaú|itau|allianz|santander|<your_client_list>'
   ```
- [ ] **No LIFT-derived phrases verbatim.** Grep `Notes.md` Anonymization Log for any phrase that traces back to LIFT and verify the CV doesn't contain it.
- [ ] **No internal McKinsey jargon** (DMS, PD, GLAM, EM-1, etc.) — these will confuse non-McK readers.
- [ ] **No personal pronouns** (`I`, `my`, `we`).
- [ ] **No passive voice** (`was responsible for`, `was tasked with`, etc.).
- [ ] **Dates consistent format** — all `MMM YYYY – MMM YYYY` OR all `YYYY – YYYY`, not mixed.

---

## 6. Keyword check (for JD-tailored variants)

Open your tailored variant alongside the JD. The CV should contain:
- Every **min qual** keyword that you honestly clear (verbatim, not paraphrased).
- Most **preferred qual** keywords where they fit honestly.
- 8–15 keywords from the JD's "responsibilities" or "about the role" text.

If you can't find 5+ JD keywords in your CV text, the agent under-tailored. Re-prompt:

> Re-tailor more aggressively. Mirror the JD's vocabulary literally — `<keyword1>`, `<keyword2>`, … — across the bullets where it's true.

---

## 7. Visual check (the human side)

Skim the PDF in 6 seconds with your eye unfocused. You should pick up:
- Your name
- 2–3 strong outcome numbers ("$40–60M", "200+ engineers", "45% reduction")
- The most recent company name
- The most recent role title
- Your education

If none of those pop, the CV is too flat. Front-load impact in the most-recent role's first bullet.

---

## 8. Portal-specific tweaks

| Portal | Quirk | Workaround |
|---|---|---|
| Workday | Strict parser; sometimes mis-parses photos as junk | Submit the ATS-only no-photo variant (see Playbook B Step 6) |
| Greenhouse | Reasonable; takes the styled PDF fine | Default variant works |
| Lever | Same as Greenhouse | Default variant works |
| LinkedIn Easy Apply | Tries to parse the PDF into structured fields; you'll review/edit | Default variant works; review the parse before submitting |
| Government / public-sector | Often want a specific format (forced .doc, no photo) | Generate ATS-only variant + manually convert to .docx via Pandoc if asked |
| Google Careers | Generally fine with styled PDFs | Default variant works |

---

## 9. The "Notepad test"

If you really want to know what an ATS sees: open the PDF, select all (Cmd+A), copy, and paste into Notepad / TextEdit (plain text mode).

The result should be readable end-to-end with no scrambled text, no missing sections, no garbage characters. This is exactly what most ATS parsers will index.

---

## When in doubt

Submit both:
1. The styled PDF (default LEAP output)
2. An ATS-only plaintext PDF (no photo, default fonts, minimal styling)

Many portals let you upload a second supplemental document. The styled version impresses humans; the plaintext version reassures parsers.
