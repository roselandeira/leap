# Playbook A — Build a CV from Scratch

> Use this playbook the first time you run LEAP. It walks you through producing a Vanilla CV, a Master Pool, and a Notes file from your raw inputs.
>
> Estimated time: **2–4 hours of your time**, spread across two sessions (one to drop inputs and confirm Phase 1; one to answer the Metrics Questionnaire after the agent identifies gaps).

---

## Step 0 — Prerequisites

You should have:

- [ ] Cursor installed
- [ ] Google Chrome installed
- [ ] Python 3 with `pypdf` (`pip install pypdf`)
- [ ] Cloned this repo (or copied the `templates/outputs_scaffold/` folder to your own working directory)

---

## Step 1 — Gather your inputs

Create an `inputs/` folder in your workspace and drop the following:

### Required
- **`linkedin.pdf`** — export your public LinkedIn profile as a PDF. (LinkedIn → your profile → More → Save to PDF.)
- **`reference_cv.pdf`** — a CV from someone whose style you admire (an MBA classmate, alumnus, mentor). Used as a style oracle only — its content will never appear in your CV. Pick one that mirrors your target flavor (consulting/MBA for industry-business roles; tech/engineering for SWE/PM/data roles).

### Strongly recommended (you're a McKinsey person — use this)
- **`feedback_memos/`** — drop all your ROYGs, Mid-Cycle, and Annual Review memos here. The more cycles you include, the better LEAP can triangulate themes that recur across engagements.
- **`lift_reports/`** *(optional but rich)* — drop your LIFT reports here. LEAP will use them for leadership / people-development theme-mining but will never quote them.

### Optional
- **`older_cvs/`** — any previous CV (even outdated). Useful as a secondary source for dates and forgotten details.
- **`extras.md`** — a free-form note. Suggested contents:
  - Themes you want to emphasize (e.g., "AI experience, strategy work")
  - Tools you actively use (e.g., Cursor, Claude Code, Python, SQL)
  - Awards, certifications, exchanges, scholarships
  - Languages and proficiency
  - Nationality and work authorization
  - Any context that's NOT in the memos (e.g., side projects, pro bono, teaching)

### If you're NOT from McKinsey
Replace the McKinsey-specific docs with their equivalents:
- Performance reviews from your firm (Google PCM packets, Microsoft Connect docs, etc.) → `feedback_memos/`
- 360 reviews or skip-level feedback → `feedback_memos/`
- Anonymized team feedback (LIFT-equivalent) → `lift_reports/`

---

## Step 2 — Open the workspace in Cursor and load LEAP

Open the folder in Cursor. Make sure `system_prompt.md` (from this repo) is accessible — either:
- Clone the repo as a sibling and point to it via `@` references, OR
- Copy `system_prompt.md` into your workspace root, OR
- Install LEAP as a Cursor Skill (see the `.cursor/skills/leap/` folder in this repo).

In Cursor chat, prompt:

> Load LEAP from `system_prompt.md` and run Phase 1 on my inputs in `@inputs/`.

The agent will read your reference CV and return a Phase 1 analysis (5–8 bullets) covering:
- Template flavor it follows (consulting/MBA, tech, or hybrid)
- Bullet patterns and quantification density
- Formatting conventions
- Tone and vocabulary
- What you should NOT copy
- Suggested flavor for **you** given your LinkedIn profile

**Read this carefully.** Confirm or push back. If the agent's suggested flavor differs from what you want, say so before moving on.

---

## Step 3 — Phase 2: Inputs Analysis

Once Phase 1 is locked, prompt:

> Run Phase 2.

The agent will read all your inputs and return:
- **Theme map** — 3–5 recurring strengths/positionings across your career
- **Date gap list** — any unexplained timeline gaps
- **Metrics gap list** — every bullet candidate without a quantifiable outcome
- **Ambiguity list** — inconsistencies between sources

If the Metrics Questionnaire is generated (which is likely — McKinsey memos are great on qualitative but light on numbers), open `outputs/_shared/metrics_questionnaire.md` and fill it. Take your time. **The quality of your Vanilla CV depends entirely on the quality of this file.**

Typical questions you'll see:
- "For Engagement X, what was the team size you led, the geography, the $/% outcome, and the lever?"
- "At Tech Corp, how many deals did you close? What was the aggregate ACV or deal-size range?"
- "What languages and work authorization should I list?"

Don't fabricate numbers. If you genuinely don't remember, say "unknown" — LEAP will pick a defensible framing (e.g., scale-only instead of $-impact).

---

## Step 4 — Phase 3: Drafting

When the questionnaire is filled, prompt:

> Phase 2 complete — drafts please.

The agent produces three artifacts:

### (a) `outputs/Vanilla/CV.{html,md,pdf}` — your master CV
One page, ATS-friendly, ready to send for any generic application. Render the PDF if not already:

```bash
./outputs/_shared/render.sh build Vanilla CV
# (or just: ./outputs/_shared/render.sh status to verify it's already there)
```

### (b) `outputs/_shared/Master.md` — your bullet pool
Every bullet LEAP generated, including ones cut from the Vanilla for length. Each bullet tagged (`#strategy`, `#ai-impact`, `#leadership`, `#international`, etc.). This is the source of truth for all future role-tailored variants.

### (c) `outputs/_shared/Notes.md` — your decision log
- Chosen flavor and why
- Reference patterns applied / skipped
- **Assumptions you need to validate** (read these!)
- Anonymization log (private — never commit if you're using a shared repo)
- ATS export checklist
- Generic keywords already woven in

Open `Notes.md` and read every assumption. If any is wrong, correct it and ask the agent to re-render.

---

## Step 5 — Validate ATS-safety

```bash
# Confirm the PDF has a clean text layer (not an image)
pdftotext outputs/Vanilla/CV.pdf -
```

You should see your full CV content as text. If you see garbled output or empty results, the PDF is image-only and won't pass ATS. (This shouldn't happen with LEAP's HTML template, but worth verifying once.)

Also confirm:
- [ ] 1 page only (`./outputs/_shared/render.sh status` shows `1` for pages)
- [ ] No literal client names (search the PDF text for any McKinsey client you worked with — should return zero matches unless the engagement is publicly disclosed)
- [ ] No LIFT-derived phrases verbatim
- [ ] Phone, email, LinkedIn are correct
- [ ] Photo (if used) is professional and the file size is reasonable (~100 KB)

---

## Step 6 — You're done with Vanilla. Now what?

You now have:
- An always-current Vanilla CV for generic applications, networking, and referrals
- A tagged Master Pool ready for per-JD tailoring
- A decision log that future-you (or future-LEAP-sessions) can pick up cold

**When a specific JD lands**, switch to **Playbook B: Tailor for a JD**. That's where the per-role variants come from.

**When new feedback memos or LIFT reports arrive** (next cycle), drop them in `inputs/feedback_memos/` and prompt:

> Re-run Phase 2 with the new memos and update the Master Pool. Diff vs the current Vanilla.

LEAP will surface new themes, add new bullets to `Master.md`, and propose Vanilla updates without overwriting your decisions.

---

## Troubleshooting

### "The agent is inventing metrics."
Stop it. Re-prompt with: "Never fabricate. Re-flag every bullet that lacks a real input number into the Metrics Questionnaire."

### "The Vanilla is 2 pages."
Prompt: "Trim to 1 page. Cut the lowest-impact bullets first; consolidate the Education section to one line per institution."

### "The agent is copying phrases from my reference CV."
Stop it. Re-prompt: "The reference CV is a style guide, not a content source. Re-check every bullet for any literal phrase from the reference and rewrite it with my content."

### "The agent named a McKinsey client."
Stop it. Re-prompt: "Apply the anonymization rules in `system_prompt.md` §4. Replace [client name] with a sector+scale descriptor and log the mapping in Notes.md."

### "My render.sh output is multi-page."
The HTML overflowed. Either trim content in the HTML, or reduce CSS spacing in the variant's `<style>` block. The script flags this automatically; the agent can also help reduce.
