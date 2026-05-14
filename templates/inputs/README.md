# inputs/ — Where Your Raw Career Artifacts Live

Drop everything LEAP needs to read here. The structure below is suggested, not enforced — but following it makes the agent's job 10× easier.

## Required

- **`linkedin.pdf`** or **`linkedin.md`**
  Your LinkedIn profile. Either export as PDF (LinkedIn → your profile → More → Save to PDF) or paste the full text into a markdown file.

- **`reference_cv.pdf`** or **`reference_cv.md`**
  One CV from someone else, used as a **style oracle only**. Never copied. Pick someone whose layout you admire and whose target industry matches yours.

## Strongly recommended (for McKinsey current/alumni)

- **`feedback_memos/`**
  Drop all your ROYG, Mid-Cycle, and Annual Review memos here. PDF or DOC, doesn't matter.
  Suggested filenames: `2024_annual.pdf`, `2024_midcycle.pdf`, `2023_annual.pdf`.

- **`lift_reports/`** *(optional but rich)*
  Drop your LIFT reports (the anonymous team-feedback compilations). LEAP uses them for theme-mining and never quotes them.

## Optional

- **`older_cvs/`**
  Any prior CV (even outdated). Useful for dates, education details, and forgotten engagements.

- **`extras.md`**
  A free-form text file. Suggested contents:
  ```
  ## Themes I want to emphasize
  - AI experience
  - Strategy work
  - International project delivery

  ## Tools I use regularly
  - Cursor, Claude Code, GitHub Copilot
  - Python, SQL

  ## Awards / certifications / exchanges
  - [Anything not in your LinkedIn or memos]

  ## Languages
  - Portuguese (Native), English (Fluent), Spanish (Fluent)

  ## Nationality / work authorization
  - Brazilian and Spanish citizen (EU work authorization)

  ## International project experience
  - [Countries where you delivered on-site]

  ## Anything else worth flagging
  - [Pro bono, teaching, side projects, advisory roles]
  ```

- **`target_jd.md`** *(per round)*
  When tailoring for a specific role, paste the full JD here.

## If you're NOT from McKinsey

Use these substitutions:

| McKinsey artifact | What to drop instead |
|---|---|
| ROYG / Annual Review | Performance review docs from your firm |
| LIFT reports | Anonymous 360s, skip-level feedback, team retros |

## Privacy

Files in `inputs/` are **never committed** to the LEAP repo (see `.gitignore`). They live only on your machine. The agent reads them locally and discards them between sessions.

The fictitious example at `examples/maria_silva/inputs/` is the only `inputs/` content tracked in git — and every line of it is fabricated for illustration.
