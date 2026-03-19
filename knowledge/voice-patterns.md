# Voice Patterns: Andamio Lessons

Patterns extracted from feedback on lesson drafts. Reference when writing new lessons.

---

## Sentence Rhythm

### Do

- **Use short punchy sentences for emphasis** — but sparingly. "Andamio works differently." hits because it's surrounded by longer sentences.
- **Vary sentence length** — keep the reader engaged by mixing short declaratives with longer explanatory sentences.
- **Use tricolons in a single sentence** — "delete it, revoke it, or take it away" flows better than three separate sentences.
- **Name the thing** — "Your Access Token is yours" grounds the reader better than "It's yours" after a pronoun chain.

### Don't

- **String multiple short sentences together** — "No company can delete it. No platform can revoke it. You carry it with you." creates a lulling pattern that loses impact.
- **Let rhythm become predictable** — if the reader can anticipate your sentence structure, you've lost them.

---

## Examples

**Before (lulling pattern):**
> No company can delete it. No platform can revoke it. You carry it with you.

**After (varied rhythm, named subject):**
> No one can delete it, revoke it, or take it away. Your Access Token is yours and it travels with you.

---

---

## Key Messaging

### Privacy Framing

Traditional platforms build a private dossier about you. Andamio doesn't collect private data — it publishes verifiable attestations (credentials) on a public ledger that any app can read.

**Minimal disclosure principle:** Your on-chain identity contains only what's needed to prove your credentials — nothing more. No activity logs, browsing history, or behavioral profiles.

**Use:** "Your on-chain identity is minimal by design: just your alias and the credentials you've earned."

**Note:** Don't claim formal zero-knowledge systems. The principle is selective disclosure — share only what's needed to prove the attestation.

### Portability Framing

Prefer "across apps" over "across organizations" — emphasizes interoperability in simpler, more concrete terms.

**Use:** "portable across apps"
**Avoid:** "across every organization using Andamio"

---

## Platform Facts

Verified platform behaviors that must be accurately represented in lessons. Incorrect assumptions here lead to wrong lessons.

### Module Structure

Every course module has three parts:
1. **SLTs** — always present, define the credential
2. **Lessons** — optional content that teaches the SLTs (not every module has lessons)
3. **Assignment** — what you submit to prove you've met the SLTs and earn the credential

### Access Model

- **Lessons are public.** Anyone can browse and read lesson content without connecting a wallet or enrolling.
- **There is no "Enroll" button.** Enrollment happens when the first assignment commitment is submitted on-chain.
- **The commitment transaction IS the enrollment transaction.**

### Assignment Submission

Two-phase process:
1. **Lock My Work** — generates a Blake2b-256 hash of your evidence (the Submission Hash)
2. **Submit Assignment** — commits the hash on-chain via wallet transaction

### Cost Model

- First assignment commitment in a course includes a **deposit** (~2-3 ADA) that stores enrollment and progress info on-chain
- Subsequent assignments in the same course cost only a minimal transaction fee
- The deposit is **returned** when you claim the credential after completing the course

### Login Flow

- First visit: "Get Started" → Enter → wallet connection → mint Access Token (one-time)
- Subsequent visits: "Enter" → wallet selector (Mesh SDK) → sign message (not a transaction, no ADA spent) → dashboard

---

## Source

- Lesson 1.1 feedback (2026-02-27)
- Lesson 3.1/3.2 corrections (2026-02-28) — platform behavior clarifications
