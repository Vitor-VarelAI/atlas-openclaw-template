# Ralph Loops - Reference Guide

> Saved for future installation when doing landing pages, trading, or ThreeJS projects.
> Source: https://www.clawhub.ai/qlifebot-coder/ralph-loops

## What It Does

Transforms Clawdbot from one-shot assistant → **autonomous builder**

- **Never loses context** - Each iteration starts fresh
- **Interview → Plan → Build** workflow
- **Real-time dashboard** at `:3939`
- **RALPH_DONE signal** - knows when actually finished

---

## Architecture

```
INTERVIEW (5 iter) → PLAN (1 iter) → BUILD (N iter) → DONE
                           ↓
                     progress.md (ground truth)
                           ↓
                     Dashboard (:3939)
```

## Phases

| Phase        | What Happens            | Output                   |
| ------------ | ----------------------- | ------------------------ |
| 1. Interview | Agent asks questions    | `specs/*.md`             |
| 2. Plan      | Breaks specs into tasks | `IMPLEMENTATION_PLAN.md` |
| 3. Build     | One task per iteration  | Working code + tests     |
| 4. Generic   | Freeform loops          | Anything needed          |

---

## Economics

| Complexity     | Iterations | Cost   | Time    |
| -------------- | ---------- | ------ | ------- |
| Simple task    | ~10        | ~$0.50 | ~15 min |
| Medium project | ~30        | $2–5   | 1–2 hrs |
| Complex build  | 100+       | $15–30 | 4–8 hrs |

---

## Quick Start

```bash
# Install the skill
clawdhub install ralph-loops

# Set up dashboard
cd skills/ralph-loops/dashboard && npm install

# Start dashboard
node skills/ralph-loops/dashboard/server.mjs
# http://localhost:3939

# Run a loop
node skills/ralph-loops/scripts/ralph-loop.mjs \
  --prompt /path/to/task.md \
  --max 20 \
  --name "My First Loop"
```

---

## Key Files

- `scripts/ralph-loop.mjs` — Core loop runner
- `templates/PROMPT_*.md` — Phase-specific prompts
- `dashboard/` — Live UI with transcripts and kill switch

---

## Why It Works

1. **One task per iteration** - AI fails when touching 5 files at once
2. **State lives in files** - Context windows lie, files don't
3. **Numbered guardrails** - Hard priorities override scope expansion
4. **Failures are data** - Tune prompts, not code
5. **Backpressure** - Tests/linting run before next iteration

---

_Based on Ralph technique from ghuntley.com/ralph_
