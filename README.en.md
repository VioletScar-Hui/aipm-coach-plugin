# AIPM Interview Coach Plugin

[中文](README.md) | [English](README.en.md)

![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-6B46C1)
![Skills](https://img.shields.io/badge/Skills-5-111827)
![AIPM](https://img.shields.io/badge/AIPM-Interview%20Prep-00B96B)
![Self-improving Loop](https://img.shields.io/badge/Loop-Self--improving-7B61FF)
![Language](https://img.shields.io/badge/Language-ZH%20%2B%20EN-blue)
![License](https://img.shields.io/github/license/VioletScar-Hui/aipm-coach-plugin)
![Status](https://img.shields.io/badge/Status-Active-success)

`aipm-coach` is a Claude Code plugin — a **self-improving, cross-interview** preparation loop for AI Product Manager (AIPM) candidates. It turns every interview into a closed loop you can debrief, distill, and target-train against, so each round makes the next one sharper.

It is not a static question bank, and not a one-off "fix my resume" pass. The core mindset is **loop engineering**: every session is an "amnesiac shift worker" — the previous shift's memory lives only in the knowledge-base files — so the system **reads state first, works in small increments, and persists immediately**, closing the loop of interview → debrief → distill → reinforce → stronger next round.

It also ships a safeguard you rarely see elsewhere: **writer-vs-checker verification** — one agent writes the debrief, then a **fresh-context** reviewer grades it against a single rubric to catch what the writer talked itself into, with deterministic guardrails that prevent fabrication and accidental edits to your resume.

This repository includes a [`LICENSE`](LICENSE) file.

---

## How It Works (The Loop)

```text
   ┌────────── aipm-coach/ (cross-interview knowledge base = memory) ──────────┐
   │  _rubric · weak-spots · question-bank · star-stories · evals             │
   └───▲────────────▲─────────────▲──────────────▲────────────────────────────┘
       │write        │read/write   │read          │read
 after→ /aipm-retro → /aipm-eval   /aipm-resume   /aipm-prep →before
        debrief Q-by-Q  fresh-ctx    resume &       sprint
                        review       talking points  briefing
```

Each debrief makes `weak-spots.md` richer, and `/aipm-prep` always drills your most frequent mistakes first — that is what "gets sharper the more you use it" means.

---

## When To Use

For people preparing for AIPM / AI-application PM interviews who want **honest diagnosis + ready-to-say model answers + cross-session accumulation**.

- "I just finished an interview, help me debrief it" → diagnosis + distillation
- "Check whether that debrief is actually reliable" → independent review
- "Rewrite my resume / refine my self-intro pitch" → resume & talking points
- "I interview at X tomorrow, help me sprint" → targeted briefing

Not for: a generic question list, or one-line surface advice. The value compounds with the number of interviews you debrief; running it empty has little point.

---

## Prerequisite

Core features need only **Claude Code** (desktop / CLI / IDE extension) — all state is local markdown, no API keys or databases.

**Optional**: install and log in to the npm `lark-cli` to unlock two enhancements — auto-generate a Feishu/Lark docx debrief after each retro (with a link back), and auto-transcribe interview audio/video into a transcript for the debrief. It still runs without it, degrading gracefully (the debrief doc is saved locally, transcripts pasted manually) and **never fails the debrief over this**.

---

## Installation

`aipm-coach` installs from a marketplace. The three methods below are equivalent — they differ only in **where you type the command**.

### Option 1 — inside a Claude Code session (recommended)

First launch Claude Code from your system terminal (PowerShell / Terminal / bash):

```bash
claude
```

Once the interactive prompt `>` appears, type the slash commands **at that `>` prompt** (not in the system terminal):

```text
/plugin marketplace add VioletScar-Hui/aipm-coach-plugin
/plugin install aipm-coach@aipm-coach-marketplace
```

> `/plugin` is a **built-in Claude Code slash command** — it only works inside a Claude Code session. Pasting it into PowerShell / bash fails with `command not found`.

### Option 2 — from the system terminal (no session)

Use the `claude` subcommands directly, suitable for scripts:

```bash
claude plugin marketplace add VioletScar-Hui/aipm-coach-plugin
claude plugin install aipm-coach@aipm-coach-marketplace
```

### Option 3 — local trial (no install, for development)

```bash
claude --plugin-dir ./plugins/aipm-coach
```

**Restart Claude Code after installing** so the skills load. They appear namespaced: `/aipm-coach:aipm-retro`, `/aipm-coach:aipm-eval`, etc. (see `/help`).

---

## First Run

1. **Scaffold the knowledge base**: say "initialize the aipm knowledge base" to trigger `/aipm-coach:aipm-setup`, which copies templates into the current project's `aipm-coach/` (existing files are **never overwritten**).
2. **Fill two source files**: `aipm-coach/profile.md` (your job-search profile) and `aipm-coach/resume-current.md` (paste your resume).
3. **Debrief your first interview**: say "debrief my interview" and paste the transcript / recall → `/aipm-coach:aipm-retro` diagnoses and distills. After 1–2 debriefs, `/aipm-prep` briefings become genuinely targeted.

---

## The Five Skills

| Command | What it does | Example triggers |
|---|---|---|
| `aipm-retro` | Q-by-Q diagnosis + model answers grounded in your real resume + distills into the knowledge base | "debrief my interview / I just finished / how did I do" |
| `aipm-eval` | Dispatches a fresh-context reviewer to grade the debrief against `_rubric.md` (writer-vs-checker); logs misses | "check this debrief / is this debrief reliable / run evals" |
| `aipm-resume` | Rewrites resume bullets (XYZ form) for AIPM + distills self-intro / project / AI talking points | "rewrite my resume / refine my pitch / how to say my self-intro" |
| `aipm-prep` | Turns accumulated experience into a "finish-it-today" targeted briefing + mock follow-ups | "I interview at X tomorrow / pre-interview sprint" |
| `aipm-setup` | Idempotently scaffolds the knowledge-base templates into `aipm-coach/` on first use | "initialize the aipm knowledge base" |

---

## Advanced Capabilities

As debriefs deepen, `aipm-retro` / `aipm-prep` pull in deeper tools on demand (skip them if you just want a basic debrief — nothing is forced):

- **Advanced diagnosis** (`_diagnosis-plus.md`): four-layer attribution (delivery / thinking / knowledge / mindset — which decides the fix), follow-up tree + break-point prediction, gap-to-perfect checklist, interviewer-intent decoding, credibility audit, the **interviewer-reaction signal** (probe / nod / instant skip — more reliable than self-assessment), and a knowledge-gap split into "don't know" vs "never done" (never-done → repackage past experience via aipm-resume).
- **Active training** (`drills.md`): instant re-answer + delta log, spoken-delivery check, spaced-repetition queue (prep pulls "due today" items first).
- **Visible progress** (`progress.md`): weak-spot status timeline, **cross-interview meta-patterns** (stable failure modes that surface only after several rounds), milestones.
- **Feishu output** (optional `lark-cli`): auto-generates a Feishu docx debrief with a link after each retro, and can auto-transcribe interview audio/video for the debrief.

## Core Design (Why It's Reliable)

- **Built for the amnesiac.** All experience is persisted into `aipm-coach/` files; a new session reads state before acting, surviving any session or context reset.
- **Machine-checkable done criteria.** Every question has a diagnosis, every weak spot has a concrete improvement action, every artifact file exists and is non-empty — not "it felt good."
- **Writer-vs-checker verification.** `aipm-eval` always dispatches a **fresh-context** subagent to grade; the writer never grades itself (too lenient).
- **No fabrication.** Model answers use only real resume / STAR material; missing facts are marked `[fill in: …]`, never invented numbers or projects.
- **Deterministic guardrail (hook).** Writing a "graded artifact" (resume / profile / rubric / eval expected verdicts) requires confirmation — preventing unauthorized overwrites and reward hacking.
- **Crash-safe + idempotent.** Persist after each question, so an interruption loses nothing; similar questions merge instead of duplicating.
- **Gets sharper.** `weak-spots.md` accumulates counts, and `/aipm-prep` always attacks your most-recurring gaps first.

---

## Knowledge Base (aipm-coach/)

| File | Purpose |
|---|---|
| `_rubric.md` | The single scoring rubric (10 dimensions + hard constraints) — guardrail-protected |
| `weak-spots.md` | Weak-spot ledger (the core accumulating state) |
| `question-bank.md` | Question bank + model answers (cross-interview, deduped) |
| `star-stories.md` | Reusable real STAR material |
| `_diagnosis-plus.md` | Advanced diagnosis toolbox (four-layer attribution / follow-up tree / gap-to-perfect / intent decoding / credibility audit) |
| `drills.md` | Active-training board (re-answer delta + spaced repetition + spoken check) |
| `progress.md` | Progress dashboard (status timeline / cross-interview meta-patterns / milestones) |
| `profile.md` / `resume-current.md` | Job profile / resume source (your files, guardrail-protected) |
| `evals/` + `eval-log.md` | Eval fixtures + review audit log |
| `sessions/` | Per-interview debrief / sprint archives |

---

## Using It In Obsidian (optional)

For the Obsidian experience — graph view, Dataview queries, spaced-repetition review — use the `plugins/aipm-coach/templates-obsidian/` variant (one-note-per-entry + frontmatter + wikilinks + a Dataview dashboard). Four steps:

**1 — Install Dataview.** Obsidian → Settings → Community plugins → turn off Restricted mode → Browse → search `Dataview` → Install and Enable (the dashboard uses DQL only; no JS queries needed).

**2 — Put the variant in your vault.** Copy the whole `templates-obsidian/aipm-coach/` folder into your vault (root or any subfolder — `tags` aggregation is path-independent); then copy 4 reference files from the default templates. Run from the repo root (replace `<VAULT>`):
```bash
cp -r plugins/aipm-coach/templates-obsidian/aipm-coach "<VAULT>/aipm-coach"
cp plugins/aipm-coach/templates/aipm-coach/{_rubric,_diagnosis-plus,profile,resume-current}.md "<VAULT>/aipm-coach/"
```

**3 — Open the dashboard + graph.** Open `aipm-coach/_dashboard.md` as your review home (drills due today/overdue · unbeaten weak spots by recurrence · questions to practice ❌🔄 · recent debriefs · milestones); open Graph view to see weak-spot ↔ question ↔ story ↔ session links.

**4 — Daily flow.**
- When debriefing, have Claude file entries per the convention: "save this weak spot as `aipm-coach/weak-spots/W3 xxx.md` with `tags: [aipm/weak-spot]` and a `[[related question]]` link."
- A drill's `due` date surfaces it in the dashboard's "due" view that day; after practicing, push `due` out (1d→3d→7d), and after 3 clean passes set `mastery: ✅`.

> "Obsidian-first" mode — pick it **or** the default fully-automated flat templates; don't mix both in one `aipm-coach/`. Frontmatter field conventions: see `templates-obsidian/README.md`.

## Repository Structure

```text
aipm-coach-plugin/
  README.md / README.en.md          # Chinese / English home pages
  LICENSE
  .claude-plugin/marketplace.json   # marketplace manifest
  plugins/aipm-coach/
    .claude-plugin/plugin.json
    README.md                       # plugin-level guide
    skills/   aipm-retro | resume | prep | eval | setup
    agents/   aipm-reviewer.md       # fresh-context reviewer
    hooks/    hooks.json + guard-source-files.sh
    templates/aipm-coach/            # empty KB templates + generic _rubric/_diagnosis-plus + drills/progress + eval fixtures
    templates-obsidian/              # Obsidian-flavored variant (per-note + frontmatter + Dataview dashboard)
```

---

## Updating

- **As a user**: run `/plugin marketplace update`, then restart Claude Code.
- **As the maintainer**: `git push` your changes and bump `version` in `plugins/aipm-coach/.claude-plugin/plugin.json` so users receive the update.

---

## Troubleshooting

**The skill does not trigger** — use an explicit trigger phrase (see the table), or invoke `/aipm-coach:aipm-retro` directly.

**It keeps asking to confirm writes** — that is the guardrail protecting your resume / profile / rubric / eval expected verdicts. Approve it; these "graded artifacts" are meant to be read-only. The `cp` used by scaffolding does not trigger it.

**Data privacy** — your real resume / weak spots / debriefs live only in your local `aipm-coach/` and are **never distributed with the plugin**; the plugin repo contains only logic and empty templates.

---

## License

This repository includes a [`LICENSE`](LICENSE) file. See that file for details.
