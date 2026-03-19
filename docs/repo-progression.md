# How lesson-coach-v2 Was Built: Experiments & Outcomes

A step-by-step account of the experiments, discoveries, and iterations that shaped this repo from Feb 25 to Mar 14, 2026.

---

## Phase 0: Foundation (Feb 25)

Starting point: research on SLTs (Student Learning Targets) as the atomic unit for human-agent collaboration. Wrote `research/slt-research-report.md` grounding the approach in Marzano, Stiggins, and Bloom's Taxonomy.

Key bet: SLTs — "I can..." statements — could serve as an interface contract between humans and AI agents, not just a pedagogical tool.

## Experiment 1: Draft SLTs by hand (Feb 25)

Created initial SLT sets for three courses: Contributors, Course Creators, Go PBL. Immediately hit formatting inconsistency — SLTs weren't in consistent "I can..." phrasing.

**Fix:** Converted all SLTs to bulleted "I can" format.
**Outcome:** Established the SLT format convention that held for all future courses.

## Experiment 2: Separate concerns in course files (Feb 25)

Started with a single file per course. Realized SLT drafting and course outlining are different activities.

**Fix:** Split into `01-slts.md` (working file) and `02-course-outline.md` (structure). Later simplified further to `01-slts.md` + `00-course.md` (Feb 27).
**Outcome:** The numbered file convention (`00-` through `05-`) became the workflow backbone.

## Experiment 3: Build the `/draft-slts` skill (Feb 25)

First Claude Code skill created. Generates SLTs from topic + audience + learning goals.

**Outcome:** Worked, but quality varied. Led directly to needing `/assess-slts`.

## Experiment 4: Restructure Contributors SLTs around the contribution loop (Feb 25)

Original SLTs were feature-oriented ("I can use the dashboard"). Restructured around what a contributor actually does: get identity → browse courses → earn credentials → contribute.

**Outcome:** 4-module structure that survived to final build. Proved that organizing by learner journey beats organizing by platform features.

## Experiment 5: Build the full assessment pipeline (Feb 27)

Created `/assess-slts`, `/self-assess-readiness`, `/classify-lesson-types` skills in rapid succession. Ran the Contributors course through the entire pipeline in one session.

**Outcome:** Pipeline worked end-to-end. Produced quality reviews, readiness tiers (6 Ready / 33 Needs Context / 5 Needs Human on Go PBL baseline), and lesson type classifications.

## Experiment 6: Init compound knowledge system (Feb 27)

Created `knowledge/` directory with `index.yaml`, verb bank, quality issues, heuristics. First `/compound` run extracted patterns from the 3 initial courses.

**Outcome:** The compounding loop — skills read knowledge before running, write after running — became the system's core value proposition. Verb bank started at 0, now at 33.

## Experiment 7: Build first lessons — Contributors Modules 1-3 (Feb 27-28)

Wrote 9 lessons across Modules 1-3 using screenshot tiers. Multiple lessons built on wrong assumptions:

- Assumed lessons required enrollment to view (wrong — lessons are public)
- Assumed there was an "Enroll" button (wrong — enrollment = first assignment commitment)
- Assumed single-step submission (wrong — two phases: Lock My Work → Submit Assignment)

**Outcome:** Established that Product Demo readiness should be rated Weak on conceptual dimension unless platform behavior is verified, not just assumed. Captured 5 platform facts into knowledge base.

## Experiment 8: Nostr Relay course — generalization test (Mar 1-2)

Deliberately built a non-Andamio course to test whether the workflow generalizes. All 10 lessons completed in about a day.

**Key findings:**
- Workflow generalizes cleanly. Terminal/config courses are mostly How To Guides.
- Context gathering was dramatically simpler — two `gh api` calls unlocked 7 "Needs Context" SLTs.
- Discovered "define before configure" heuristic: policy definition is Exploration even in procedural courses.
- Student testing revealed "silent success" anti-pattern (lessons that complete without verification).

**Outcome:** Proved the system isn't Andamio-specific. First course promoted to `courses/`.

## Experiment 9: Subbit.xyz — Developer Documentation heavy course (Mar 4)

21 SLTs, 10 of which are Developer Documentation type (code + docs links). Built 18/21 lessons. Hit the Lucid → MeshJS migration mid-build.

**Key finding:** Had to rewrite all code examples when switching from Lucid to MeshJS SDK.
**Outcome:** Created the `/mesh-transaction`, `/mesh-wallet`, `/mesh-core-cst` skills to handle Cardano transaction patterns. Course backlogged pending CLI capture and expert input on 3 SLTs.

## Experiment 10: Build `/compile` skill (Mar 5)

Needed to package lessons for Andamio platform import. First version handled markdown only; immediately needed image handling.

**Outcome:** Two commits in one day — base skill then image support. Established the `compiled/` output directory.

## Experiment 11: Project Owners course — fastest build (Mar 5)

10 SLTs, all Product Demo type, built from existing Project Owner Guide docs. 8/10 rated Ready at self-assessment (highest ratio of any course). All 10 calibrated accurately at tier level.

**Outcome:** Validated that courses with strong existing documentation build fast. Confirmed the "why vs how" heuristic (understanding design rationale = Exploration, even in hands-on courses).

## Experiment 12: API Developers — endpoint validation problem (Mar 6)

Built Modules 101 and 103 (skipped 102 which was blocked on missing template files). Pre-compile audit caught 2 wrong API endpoints in Module 103.

**Outcome:** Established that Developer Documentation SLTs need endpoint validation before being marked Ready. Pre-compile audit is non-optional for technical courses.

## Experiment 13: Cardano Dev Quickstart — minimal dual-purpose course (Mar 10)

3 SLTs only. Intentionally minimal — "get devs unblocked in 10-15 minutes." Serves as both a standalone course and a prerequisite for API Developers Module 3+.

**Outcome:** Proved that small, focused courses have outsized value as prerequisites.

---

## What Compounded

After 7 courses through the system (as of Mar 16, 2026):

- **102 SLTs analyzed**, 41 lessons built
- **33 verbs** in the bank with Bloom's level mappings and success counts
- **6 quality anti-patterns** documented with proven rewrites
- **33 lesson-type heuristics** including 4 meta-heuristics that apply across all courses
- **41 calibration entries** (88% accuracy at dimension level)
- **9 voice/style anti-patterns** preventing common AI writing tics
- **9 import gotchas** preventing compile/upload mistakes
- **5 cross-cutting workflow heuristics:**
  1. Screenshots show UI, not behavior
  2. Platform facts belong in knowledge, not just lessons
  3. Product Demo conceptual readiness should be Weak unless behavior is verified
  4. Primary interface determines lesson type, not the verb
  5. `gh api` is fastest context-gathering method for open source

## Experiment 14: Andamio CLI skill + full course import (Mar 16)

Wrote 2 missing lessons (4.2, 4.3) for Contributors Module 4, then compiled and imported all 4 modules to preprod via the Andamio CLI.

**Key findings:**
- The CLI's `import` command only updates existing modules — creating new modules requires direct API calls
- SLT creation requires omitting `slt_index` from the payload (the CLI always sends it, causing silent no-ops on new modules)
- Lesson files must have `# H1` headings — the CLI extracts them as lesson titles. Without them, lessons import with blank titles.
- The `outline.md` should NOT have an H1 heading — title comes from YAML frontmatter only

**Outcome:** Created `/andamio-cli` skill documenting the full CLI workflow including workarounds. Filed 6 issues on the CLI repo. Wrote CLI docs section for andamio-docs. Updated `/compile` skill format rules. Added 4 new import gotchas to knowledge base.

## Experiment 15: Aiken PBL Module 101 — external course import (Mar 16)

Compiled Module 101 of Aiken Project-Based Learning — a pre-existing course from Gimbalabs with 3 SLTs, 3 lessons, and 13 screenshots. Source was already in near-compiled format in `courses-in-progress/`.

**Outcome:** Image path transformation (bare filenames → `assets/` relative paths) was the main compile task. Validated that the compile workflow handles external courses with pre-existing content.

## What's Still Blocked (Mar 16)

- **Contributors Module 4:** 5 screenshots still needed (4.2 project catalog, 4.3 full task flow) — add via app after upload
- **API Developers Module 2:** template missing AI context files
- **API Developers Module 4:** needs original content, no existing docs
- **Subbit:** CLI capture and expert input for 3 SLTs
- **CLI SLT creation bug:** Import silently skips SLT creation on new modules (issue #9)
- **No lesson-type-specific skills yet** (Phase B roadmap)

## Course Status Summary

| Course | Status | Lessons | Key Learning |
|--------|--------|---------|--------------|
| Cardano Dev Quickstart | complete | 3/3 | Small courses have outsized prerequisite value |
| Andamio for Contributors | **imported** | 12/12 | CLI import requires 3-step flow for new modules |
| Andamio for API Developers | building | 7/13 | Pre-compile audit catches wrong endpoints |
| Andamio for Project Owners | compounded | 10/10 | Strong docs = fast build |
| Nostr Relay Operations | complete | 10/10 | Workflow generalizes beyond Andamio |
| Subbit.xyz for Developers | backlogged | 18/21 | SDK migrations break all code examples at once |
| Aiken PBL | compiling | M101 done | External courses need image path transforms |
