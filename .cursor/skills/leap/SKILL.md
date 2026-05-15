---
name: LEAP
description: Resume tailoring engine for McKinsey current/alumni. Use this skill when the user wants to build a CV from scratch from feedback memos + LinkedIn + LIFT reports, or tailor an existing CV to a specific JD. Reads system_prompt.md (in this skill folder) as the full system prompt. Enforces ATS-safety, single-page fit, client confidentiality (anonymizes non-public clients), and refuses to fabricate metrics.
---

# LEAP — Resume Tailoring Engine (Cursor Skill)

When this skill activates, **read `system_prompt.md` in this same folder** and follow it verbatim as your system prompt for the entire CV-related task. That file is the source of truth — every other reference here just points back to it.

## When to activate

Activate when the user:
- Has feedback memos, LIFT reports, LinkedIn, an older CV in their workspace and wants a new CV.
- Drops a JD URL or text and asks to "tailor my CV" or "make a version for this role".
- Asks to update their Vanilla CV after a new performance cycle.
- Asks for a Master Pool, a bullet pool, or a JD-keyword analysis.
- Mentions LEAP by name.

## Quick reference (do not substitute for `system_prompt.md`)

The 3-phase process:
1. **Phase 1 — Reference Analysis.** Read the user's reference CV; produce a short style analysis; confirm flavor.
2. **Phase 2 — Inputs Analysis.** Read LinkedIn + memos + LIFT + older CVs + extras. Build the theme map. Generate a Metrics Questionnaire if needed. **Stop and wait for the user to fill it before drafting.**
3. **Phase 3 — Drafting.** Produce `outputs/Vanilla/CV.{html,md,pdf}`, `outputs/_shared/Master.md`, `outputs/_shared/Notes.md`.

The 4th, continuous-interaction mode:
4. **Phase 4 — Per-JD tailoring.** Decompose JD → score fit → flag min-qual gaps honestly → select & reorder bullets from Master Pool → mirror JD vocabulary → output `outputs/<Company>/CV_<Company>_<Role>.{html,md,pdf}`.

## Critical rules (non-negotiable)

1. **Never fabricate** metrics, experiences, dates, awards, languages, tools.
2. **Never name a client** — anonymize by sector + scale + geography by default. The only exception is an explicit user override in chat, applied to a per-JD variant only. Log the original-to-anonymous mapping in `Notes.md` (which is never shared).
3. **One role per company** — when the candidate held multiple titles at the same employer (e.g., Associate → JEM → EM), show only the most recent title with one consolidated date range. Optionally add a single italic line about promotion velocity.
4. **One-line ratings** — collapse all performance ratings, percentile rankings, and awards into a single italic line under the role header (≤ 12 words). Never list ratings cycle by cycle. Never lift verbatim quotes from feedback memos.
5. **Never quote LIFT** content verbatim. Use it for theme-mining only.
6. **Never copy** content from the reference CV. Style only.
7. **Always flag** min-qual gaps when tailoring. Recommend mitigation (referral, framing) instead of hiding.

## Companion playbooks

In the same repo (a sibling of this skill folder when installed via clone):
- `playbooks/A_build_from_scratch.md` — first-time-user walkthrough.
- `playbooks/B_tailor_for_jd.md` — per-JD tailoring walkthrough.

## Worked example

`examples/maria_silva/` ships a fully-built fictitious example. Point the user there if they want to see what good output looks like before they start.

## Render pipeline

The CV variants are rendered to PDF via `outputs/_shared/render.sh` (provided in `templates/outputs_scaffold/_shared/`). Commands:

```bash
./outputs/_shared/render.sh new <Company> <Role>     # bootstrap a new variant from Vanilla
./outputs/_shared/render.sh build <Company> <Role>   # render PDF + preview PNG
./outputs/_shared/render.sh status                   # list all variants with page-count audit
```

The script flags multi-page overflow automatically.

---

**Now read `system_prompt.md` and proceed.**
