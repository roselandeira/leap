# Maria Silva — LEAP Worked Example

> **Important:** Maria Silva is a fictitious person. Tech Corp is a fictitious company.
> Every name, engagement, metric, and feedback line in this folder is fabricated for illustration.
> Use this folder to understand what good LEAP output looks like — never as a source of real numbers.

---

## What you'll find here

```
maria_silva/
├── README.md                              # This file
├── inputs/                                # The raw artifacts Maria dropped in
│   ├── linkedin.md                        # Her LinkedIn export
│   ├── feedback_memos/                    # Three fictitious ROYG/Annual memos
│   ├── lift_reports/                      # One fictitious LIFT report
│   ├── older_cvs/                         # Her 2022 CV (when she joined McKinsey)
│   ├── reference_cv.md                    # The style oracle she chose
│   └── extras.md                          # Free-form additional context
└── outputs/                               # What LEAP produced
    ├── Vanilla/
    │   ├── CV.html                        # The styled HTML (1-page)
    │   └── CV.md                          # Markdown mirror
    ├── _shared/
    │   ├── Master.md                      # Tagged bullet pool
    │   └── Notes.md                       # Flavor, assumptions, anonymization log, ATS checklist
    └── Nubank/
        ├── CV_Nubank_Senior-PM.html       # Phase-4 JD-tailored variant
        └── CV_Nubank_Senior-PM.md
```

---

## How to read this example

1. **Start with the inputs** to see what raw material Maria dropped in. Note the variety: LinkedIn, three memos covering different rating cycles, one LIFT report, an older CV (for date and education detail), and a reference CV from an INSEAD classmate.

2. **Read `outputs/_shared/Notes.md`** next. This is LEAP's decision log — the chosen flavor and why, every assumption flagged for the user to validate, the anonymization mapping table, the ATS export checklist.

3. **Open `outputs/Vanilla/CV.html`** in a browser. This is Maria's master CV — what she'd send for any generic application. Compare it side-by-side with the reference CV to see the style mirroring (no content copying).

4. **Open `outputs/_shared/Master.md`** to see the tagged bullet pool. Notice:
   - Multiple phrasings per engagement (alternatives held in reserve)
   - Tags like `#ai-impact`, `#leadership`, `#international`
   - "Featured" markers showing which version is in the Vanilla today

5. **Open `outputs/Nubank/CV_Nubank_Senior-PM.html`** to see what Phase-4 (JD-tailored) output looks like. Compare to Vanilla — note:
   - Tagline rewritten to "Senior Product Manager · AI-First Product & Growth"
   - Bullet order reshuffled: AI/PDLC bank engagement promoted to position 1 (high JD relevance)
   - Brazilian retail-bank loyalty bullet promoted (B2C consumer-product signal)
   - B2B marketplace bullet pulled from Master Pool into the visible set
   - International-software-firm bullet dropped (less relevant to a B2C consumer-fintech role)
   - "Methodologies" line in Skills section renamed to "Product methodologies" with discovery added

---

## The pretend Nubank JD this variant targets

For illustration, assume the JD asked for:
- 5+ years of product management or related experience
- Demonstrated experience leading AI/ML-enabled products
- Strong consumer-fintech intuition
- Experience with experimentation and growth
- Leadership of cross-functional teams
- Brazilian Portuguese + English fluency
- LATAM market knowledge

LEAP's tailoring strategy:
- Front-load the AI-first product engagement (matches "AI/ML-enabled products" + "experimentation")
- Surface the B2C banking work prominently (matches "consumer-fintech intuition")
- Add the B2B marketplace pricing engine from the Master Pool (matches "experience with experimentation and growth")
- Rephrase mentoring bullet to emphasize team NPS (matches "leadership of cross-functional teams")
- Keep international experience line (LATAM market knowledge)
- Drop the European-insurer Agile transformation bullet (less relevant)

Maria's resulting CV honestly addresses every preferred qual without inventing a single experience.
