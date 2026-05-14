# Playbook B — Tailor Your CV for a Specific JD

> Use this playbook when you already have a Vanilla CV + Master Pool (from Playbook A) and a real JD just landed.
>
> Estimated time: **20–40 minutes per JD**, including review of the diff.

---

## Step 0 — Confirm you have the prerequisites

Run:

```bash
./outputs/_shared/render.sh status
```

You should see at least:
- `Vanilla/CV.pdf` listed as 1 page.

You should also have:
- `outputs/_shared/Master.md` (your tagged bullet pool)
- `outputs/_shared/Notes.md` (your decision log)

If any of these are missing, go back to **Playbook A: Build from Scratch**.

---

## Step 1 — Drop the JD

Either:
- Save the JD as `inputs/target_jd.md` (paste the full text), OR
- Paste the JD URL directly in your Cursor chat.

If the JD is from a careers portal that blocks scraping (e.g., Revolut, some Google Cloud pages), paste the full text into chat — don't rely on the agent fetching it.

---

## Step 2 — Prompt LEAP for the tailored variant

In Cursor chat:

> Tailor my CV for this JD. Use the Master Pool. Mirror JD vocabulary literally. Flag any min-qual gap honestly.

The agent will:

1. **Decompose the JD**: extract min quals, preferred quals, and 8–15 verbatim keywords.
2. **Score your fit**: clear/yellow/red flag for each min qual; signal strength for each preferred qual.
3. **Honestly flag gaps**: any min qual you don't clear gets surfaced immediately, with mitigation suggestions (referral, cover letter framing, alternative roles).
4. **Pick + reorder bullets**: from the Master Pool, selecting by tag relevance.
5. **Rewrite framing**: mirror the JD's exact vocabulary in your bullets (without changing the underlying truth of what you did).
6. **Reframe the tagline** (the line under your name): align it with the role title without lying.
7. **Output**:
   - `outputs/<Company>/CV_<Company>_<Role>.{html,md}` (e.g., `outputs/Nubank/CV_Nubank_Senior-PM.html`)
   - A short **diff** in chat explaining what changed and why, section by section

---

## Step 3 — Render and audit

```bash
./outputs/_shared/render.sh build <Company> <Role>
```

This produces the PDF + preview PNG and reports page count. If you see `⚠ MULTI-PAGE`, prompt the agent:

> Trim the variant to 1 page. Cut the lowest-relevance bullets to this JD; keep the JD-keyword density.

Then re-build.

---

## Step 4 — Review the diff

The agent's diff should answer four questions:

1. **What I changed** — which bullets reordered, which rewritten, which dropped, which added from the Master Pool.
2. **Why** — the JD signal that justified each change.
3. **JD vocabulary I mirrored** — the verbatim keywords now woven into your CV.
4. **Gaps I flagged** — what min quals you don't fully clear and what to do about it.

**Read every line.** This is your interview prep too — every reframing the agent did is a story you should be ready to tell.

---

## Step 5 — Decide: apply, or escalate

For each role-tailored variant, ask yourself:

| Question | If yes → | If no → |
|---|---|---|
| Do I clear every min qual on the JD? | Apply via portal with this CV | Use a referral path (LinkedIn DM, alumni outreach) so a human sees the CV first |
| Is my match ≥80%? | Apply | Consider whether to apply or wait for a closer-fit role |
| Did the agent flag any gap that's a hard-block? | Don't apply cold; find a referral | Reconsider the role |

---

## Step 6 — Submit

Decide which file to upload:

- **`CV_<Company>_<Role>.pdf`** — the default. It's already ATS-safe (text layer + semantic structure). Works for ~95% of portals.
- **Plaintext fallback** — if a portal is unusually strict (e.g., bare-bones Workday, government portals), open the `.md` file, format-clean in a plain editor, and convert to a no-photo no-style PDF using:
  ```bash
  # Quick ATS-only variant (no photo, no fancy styling)
  # Open the .md in any markdown viewer that exports to PDF (Pandoc, Typora, etc.).
  ```

If you want LEAP to generate a "stripped-down ATS-safe" variant alongside the styled one, prompt:

> Also produce an ATS-only plaintext PDF for the same JD.

The agent will produce `outputs/<Company>/CV_<Company>_<Role>_ATS.pdf` with no photo, no decorative fonts, and a minimal style block.

---

## Continuous improvement

After each application:

- Note in `outputs/_shared/Notes.md` what worked and what didn't (e.g., "Recruiter mentioned the AI capability bullet first — keep front-loading that for fintech roles").
- If you learned a new metric (a final outcome number you didn't have before), update the Master Pool. Run `./outputs/_shared/render.sh build Vanilla CV` to keep the Vanilla aligned.

---

## When tailoring goes sideways

### "The agent rewrote a bullet to claim something I didn't actually do."
Stop it. Re-prompt: "Roll back. The JD vocabulary should reframe what's true, not invent new claims. Restore the original bullet and try again with strict mirroring (no new outcomes)."

### "The agent's JD scoring feels too generous."
Re-prompt: "Re-score conservatively. Treat 'preferred' bullets as gaps unless I have direct, recent experience. Surface every doubt."

### "The diff is too long; I just want the variant."
Re-prompt: "Skip the diff narrative. Just produce the variant + a 5-bullet summary of biggest changes."

### "Two roles at the same company, two different variants?"
Yes — use distinct `<Role>` slugs:
- `CV_Google_BPM-LATAM.pdf`
- `CV_Google_Strategy-Manager-Apps.pdf`

The script and folder structure handle this natively.
