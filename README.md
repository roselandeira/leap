# LEAP

**Resume tailoring engine for McKinsey current and alumni.**

LEAP turns feedback memos, LIFT reports, LinkedIn, and older CVs into a single, ATS-friendly master CV — and then tailors that master into per-role variants for specific JDs without ever fabricating content.

Built to run inside [Cursor](https://cursor.com/) with any modern LLM. Portable to Claude Code / ChatGPT.

---

## What you get

- A **3-phase process** that reads your career artifacts and produces a clean master CV in one shot.
- A **Master Pool** of tagged, reusable bullets so per-role tailoring is fast and consistent across applications.
- A **continuous-interaction mode** for tailoring against specific JDs — outputs the new CV plus a short diff explaining what changed and why.
- A **render pipeline** (`render.sh`) that turns HTML + your photo into a single-page, ATS-safe PDF and audits page-count automatically.
- **Built-in client confidentiality conventions** so you don't accidentally leak a McKinsey client name.
- A **worked example** (Maria Silva) so you can see what good output looks like before you start.

---

## Quick start

```bash
# 1. Clone
git clone git@github.com:roselandeira/leap.git
cd leap

# 2. Copy the scaffold into the directory where you want your own CV to live
cp -R templates/outputs_scaffold/ ~/my-cv/outputs/
mkdir -p ~/my-cv/inputs
cd ~/my-cv

# 3. Drop your inputs in inputs/
#    See system_prompt.md §3 for what goes where.

# 4. Open this folder in Cursor and prompt the agent:
#    "Load LEAP and run Phase 1 on my inputs."
#    The agent will read system_prompt.md (point it at the leap repo or copy
#    system_prompt.md alongside your inputs/) and start.

# 5. When the Vanilla is rendered, audit it:
./outputs/_shared/render.sh status
```

When a real JD lands:

```bash
# Prompt in Cursor: "Tailor for this JD: <URL or pasted text>"
# When the agent produces outputs/<Company>/CV_<Company>_<Role>.html, render:
./outputs/_shared/render.sh build <Company> <Role>
```

---

## Repo layout

```
leap/
├── README.md                          # You are here
├── system_prompt.md                   # The full AI instructions — the heart of LEAP
├── playbooks/
│   ├── A_build_from_scratch.md        # Step-by-step for first-time users
│   └── B_tailor_for_jd.md             # Step-by-step for per-JD tailoring
├── templates/
│   ├── inputs/                        # Empty starter scaffold for your raw inputs
│   └── outputs_scaffold/              # Empty CV + render.sh — copy this to your workspace
├── examples/
│   └── maria_silva/                   # Fully-rendered fictitious example
├── design_system/
│   ├── style.css                      # Extracted base CSS (matches the HTML template)
│   ├── design_tokens.md               # Color palette, typography, ATS-safe decisions
│   └── ats_checklist.md               # Pre-submission ATS validation
└── .cursor/skills/leap/               # Cursor Skill packaging (auto-discovered by Cursor)
    └── SKILL.md
```

---

## Two main use cases

### A. Build a CV from scratch
You have LinkedIn, feedback memos, LIFT reports, maybe an old CV. You want a clean, ATS-friendly Vanilla CV plus a Master Pool you can tailor from later.

→ Read **`playbooks/A_build_from_scratch.md`**.

### B. Tailor your CV for a specific JD
You already have a Vanilla + Master Pool. A new JD landed. You want a role-specific variant that mirrors the JD's vocabulary without inventing experience.

→ Read **`playbooks/B_tailor_for_jd.md`**.

---

## Why it exists

Most AI CV builders do two things wrong:

1. **They invent.** They'll happily make up a $50M outcome to fill a gap. LEAP refuses; it stops and asks.
2. **They ignore context.** They don't know what a ROYG memo is, what LIFT reports actually contain, or how client confidentiality works. LEAP is built around those primitives.

LEAP also enforces the boring stuff: one page, ATS-safe text layer, JD keyword mirroring without synonym substitution, quantification on every bullet, and a tag-based bullet pool that makes per-JD tailoring a 10-minute job instead of a weekend.

---

## Requirements

- **macOS** (the render pipeline uses Chrome headless + `sips`; Linux works with minor `render.sh` edits)
- **Google Chrome** installed at `/Applications/Google Chrome.app/` (for HTML → PDF)
- **Python 3** with `pypdf` (`pip install pypdf`) — used only for page-count + image-embed audit
- **Cursor** (recommended) or any LLM with filesystem access

---

## Critical rules (the short version)

These are non-negotiable. They live in `system_prompt.md` but are restated here so they're impossible to miss:

1. **Never fabricate** — metrics, experiences, dates, awards, languages, tools. If you don't have the number, you flag the gap and ask.
2. **Never name clients** that aren't publicly disclosed. Use sector + scale descriptors. See `system_prompt.md` §4.
3. **Never surface LIFT verbatim.** Use it as theme-mining signal only — never quote it.
4. **Never copy from the reference CV.** Style only, never content.

If the agent ever drifts from these, stop it and re-anchor.

---

## License

MIT. See `LICENSE`. Private to the McK-Private org; if you've been added to the org, you can use, fork, modify, and share within it freely.

---

Built with care so that the next time someone in our network needs to move roles, they don't lose a weekend re-doing what we've all already figured out.
