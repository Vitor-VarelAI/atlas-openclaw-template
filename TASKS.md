# Implementation Tasks - ThreeJS Specialist AI Assistant

## Overview

Telegram-based AI assistant for ThreeJS/3D web development freelancing.

**Architecture**: Multi-tier routing (Synthetic.new + Claude setup-token)
**Budget**: €42/month total
**Primary Use**: ThreeJS code generation for €5000+ projects

---

## Phase 1: Infrastructure Setup

### Priority: HIGH - Foundation

| Task                                | Status  | Notes                                  |
| ----------------------------------- | ------- | -------------------------------------- |
| Subscribe to Synthetic.new Standard | ⬜ TODO | $20/month, includes Kimi K2.5          |
| Verify Kimi K2.5 access             | ⬜ TODO | Check in Synthetic dashboard           |
| Test Kimi K2.5 with ThreeJS prompt  | ⬜ TODO | Validate quality before full setup     |
| Create Telegram bot                 | ⬜ TODO | @BotFather, save token                 |
| Generate Claude setup-token         | ⬜ TODO | `claude setup-token` in terminal       |
| Test setup-token API access         | ⬜ TODO | Verify it works before depending on it |

### Subscriptions Required

```
1. Synthetic.new Standard: $20/month
   URL: https://synthetic.new
   Provides: DeepSeek V3.2, Kimi K2.5, Qwen 3 VL, 16+ more models
   Rate limit: 135 req/5h (~65/day)

2. Claude Pro: $20/month
   URL: Already subscribed
   Provides: setup-token for API access ($0 extra)
```

---

## Phase 2: Bot Deployment

### Priority: HIGH - Core functionality

| Task                             | Status  | Notes                 |
| -------------------------------- | ------- | --------------------- |
| Fork/clone OpenClaw repository   | ⬜ TODO | Or create custom bot  |
| Configure Railway project        | ⬜ TODO | EU region, ~€5/month  |
| Set environment variables        | ⬜ TODO | See list below        |
| Deploy to Railway                | ⬜ TODO | Initial deployment    |
| Test basic Telegram connectivity | ⬜ TODO | Bot responds to "Olá" |
| Configure Tailscale (optional)   | ⬜ TODO | For dashboard access  |

### Environment Variables

```bash
# Required
TELEGRAM_BOT_TOKEN=<from_botfather>
SYNTHETIC_API_KEY=<from_synthetic_dashboard>
CLAUDE_SETUP_TOKEN=<from_claude_setup_token>

# Railway config
PORT=8080
OPENCLAW_STATE_DIR=/data/.openclaw
OPENCLAW_WORKSPACE_DIR=/data/workspace
TZ=Europe/Lisbon

# Safety
SETUP_PASSWORD=<generate_secure>
```

---

## Phase 3: Routing Configuration

### Priority: HIGH - Model selection logic

| Task                            | Status  | Notes                     |
| ------------------------------- | ------- | ------------------------- |
| Configure keyword-based routing | ⬜ TODO | See routing rules         |
| Set up Kimi K2.5 for ThreeJS    | ⬜ TODO | Primary use case          |
| Set up DeepSeek V3 for general  | ⬜ TODO | Default fallback          |
| Set up Qwen VL for basic vision | ⬜ TODO | Non-UI images             |
| Set up Claude for validation    | ⬜ TODO | Critical tasks only       |
| Configure fallback chain        | ⬜ TODO | Kimi → DeepSeek → Claude  |
| Test ThreeJS routing            | ⬜ TODO | "Cria uma cena 3D" → Kimi |
| Test research routing           | ⬜ TODO | "Compara X vs Y" → Swarm  |

### Routing Rules to Implement

```
ThreeJS triggers → Kimi K2.5:
  Keywords: threejs, three.js, 3d, webgl, shader, scene, mesh,
            geometry, material, texture, animation, orbit, camera

Research triggers → Kimi Swarm:
  Keywords: research, compare, analyze, top 10, alternatives

Vision triggers:
  Image + (UI/design/screenshot) → Kimi K2.5
  Image + (other) → Qwen 3 VL

Validation triggers → Claude:
  Keywords: verify, critical, importante
  Manual: @claude prefix

Default → DeepSeek V3.2
```

---

## Phase 4: PT-PT Language Layer

### Priority: HIGH - Critical for usability

| Task                                  | Status  | Notes                   |
| ------------------------------------- | ------- | ----------------------- |
| Add PT-PT system prompt to all models | ⬜ TODO | See prompt template     |
| Implement regex filter for gerunds    | ⬜ TODO | "fazendo" → "a fazer"   |
| Implement regex filter for pronouns   | ⬜ TODO | "me dá" → "dá-me"       |
| Create vocabulary substitution dict   | ⬜ TODO | tela→ecrã, etc.         |
| Test PT-PT output quality             | ⬜ TODO | Check for Brazilianisms |
| Log and fix pattern failures          | ⬜ TODO | Build pattern library   |

### PT-PT System Prompt

```
OBRIGATÓRIO: Responde SEMPRE em Português de Portugal (PT-PT), NUNCA em Português do Brasil.

Regras linguísticas PT-PT:
- Gerúndio com "a + infinitivo" (ex: "estou a trabalhar", não "estou trabalhando")
- Pronomes enclíticos (ex: "diz-me", não "me diz")
- Vocabulário PT-PT: ecrã, autocarro, telemóvel, pequeno-almoço
- Tratamento: usa "tu" implícito ou formal, evita "você"
```

### Regex Patterns

| Pattern   | Match                  | Replace       |
| --------- | ---------------------- | ------------- |
| Gerund    | `estou (\w+)ndo`       | `estou a $1r` |
| Proclitic | `^(me\|te\|lhe) (\w+)` | `$2-$1`       |
| Vocab     | `tela`                 | `ecrã`        |
| Vocab     | `celular`              | `telemóvel`   |
| Vocab     | `ônibus`               | `autocarro`   |

---

## Phase 5: Production Hardening

### Priority: MEDIUM - Stability

| Task                            | Status  | Notes                          |
| ------------------------------- | ------- | ------------------------------ |
| Configure rate limit monitoring | ⬜ TODO | Alert at 80%                   |
| Set up daily usage summary      | ⬜ TODO | Telegram DM at 23:00           |
| Implement retry logic           | ⬜ TODO | 3 retries, exponential backoff |
| Configure error handling        | ⬜ TODO | Graceful degradation           |
| Set up logging                  | ⬜ TODO | Railway + external             |
| Test fallback scenarios         | ⬜ TODO | Simulate failures              |
| Document emergency stop         | ⬜ TODO | Kill switch procedure          |

### Rate Limit Thresholds

```
Daily budget: 65 requests (Synthetic Standard)
Alert: 52 requests (80%)
Hard block: 62 requests (95%)
Message: "Limite diário atingido, a aguardar reset"
```

---

## Phase 6: Testing & Validation

### Priority: MEDIUM - Quality assurance

| Task                         | Status  | Notes                           |
| ---------------------------- | ------- | ------------------------------- |
| Test ThreeJS code generation | ⬜ TODO | "Cria cena com rotating galaxy" |
| Test research swarm          | ⬜ TODO | "Top 10 ThreeJS libraries 2026" |
| Test vision analysis         | ⬜ TODO | Send UI screenshot              |
| Test PT-PT quality           | ⬜ TODO | Check all outputs               |
| Measure response times       | ⬜ TODO | Target <5s                      |
| Test edge cases              | ⬜ TODO | Ambiguous requests              |
| Load test (light)            | ⬜ TODO | 10 requests in sequence         |

### Test Cases

```
1. ThreeJS: "Cria uma cena com partículas que formam uma galáxia rotativa"
   Expected: Kimi K2.5, complete Three.js code, PT-PT comments

2. Research: "Compara React Three Fiber vs vanilla Three.js vs Babylon.js"
   Expected: Kimi Swarm, structured comparison, sources

3. Vision: [Screenshot of broken UI]
   Expected: Kimi K2.5, identifies issue, suggests fix

4. General: "Qual é a capital de Portugal?"
   Expected: DeepSeek V3, quick answer, PT-PT

5. Validation: "@claude Verifica se este código está correto: [code]"
   Expected: Claude 4.5, detailed review
```

---

## Phase 7: Optimization (Week 2+)

### Priority: LOW - Continuous improvement

| Task                       | Status  | Notes                   |
| -------------------------- | ------- | ----------------------- |
| Analyze usage patterns     | ⬜ TODO | After 1 week            |
| Tune routing rules         | ⬜ TODO | Based on real usage     |
| Optimize PT-PT patterns    | ⬜ TODO | From logged failures    |
| Evaluate Pro plan need     | ⬜ TODO | If hitting 65/day limit |
| Prepare Amália integration | ⬜ TODO | For June 2026           |

---

## Skills to Create

### New Focused Skills

| Skill              | Purpose                       | Model               |
| ------------------ | ----------------------------- | ------------------- |
| `threejs-coder/`   | ThreeJS code generation       | Kimi K2.5           |
| `research-swarm/`  | Parallel research             | Kimi Swarm          |
| `pt-pt-filter/`    | Language normalization        | Post-processor      |
| `vision-analyzer/` | UI/design analysis            | Kimi K2.5 / Qwen VL |
| `security/`        | ACIP prompt injection defense | N/A (system prompt) |

### Local Tools Installed

| Tool | Purpose                        | Status       |
| ---- | ------------------------------ | ------------ |
| QMD  | Local semantic search for docs | ✅ Installed |
| Bun  | JavaScript runtime for QMD     | ✅ v1.3.8    |

### Future: Ralph Loops (Development)

| Use Ralph              | Don't Use Ralph   |
| ---------------------- | ----------------- |
| Build a dashboard      | Fix a typo        |
| Create an API          | Explain an error  |
| Refactor a system      | Walk through code |
| Overnight builds       | Live pairing      |
| Anything you'd babysit | Anything <5 min   |

**Best for:** Landing pages, trading systems, ThreeJS projects
**Install:** `clawhub install qlifebot-coder/ralph-loops`
**Dashboard:** `http://localhost:3939`

### Skills to Remove (Old Strategy)

```
- project-manager/
- nutrition-coach/
- personal-trainer/
- finance-tracker/
- family-hub/
- affiliate-hunter/
- seo-researcher/
- copywriter/
```

---

## Phase 8: RAG with Synthetic Embeddings (Future)

### Priority: LOW - Enhancement after base works

| Task                               | Status  | Notes                        |
| ---------------------------------- | ------- | ---------------------------- |
| Structure knowledge base files     | ⬜ TODO | Fitness, books, projects     |
| Configure Synthetic embeddings API | ⬜ TODO | nomic-embed-text-v1.5 (FREE) |
| Implement document chunking        | ⬜ TODO | Optimal chunk sizes          |
| Create vector store                | ⬜ TODO | SQLite or Pinecone           |
| Integrate RAG into OpenClaw        | ⬜ TODO | Search before answering      |
| Test RAG quality                   | ⬜ TODO | Measure relevance            |

### Benefits

- Bot searches YOUR docs before answering
- Personalized responses (fitness plans, project details)
- €0 extra cost (embeddings included in Synthetic)

### Prerequisites

- OpenClaw running on Railway (Phase 2)
- Knowledge base organized (books, fitness, projects)

---

## Quick Reference

### Day 1 Checklist

- [ ] Synthetic.new subscription active
- [ ] Kimi K2.5 tested in playground
- [ ] Telegram bot created
- [ ] Claude setup-token generated

### Day 2 Checklist

- [ ] OpenClaw deployed to Railway
- [ ] Environment variables set
- [ ] Basic routing configured
- [ ] Bot responds in Telegram

### Day 3 Checklist

- [ ] PT-PT filter implemented
- [ ] All routing rules tested
- [ ] Monitoring active
- [ ] Ready for production use

### Emergency Stop

```
Option 1: Railway Dashboard → Service → Stop
Option 2: Anthropic Console → Disable API key
Option 3: Synthetic Dashboard → Revoke API key
```

---

## Cost Tracking

| Month    | Synthetic | Claude Pro | Railway | Total |
| -------- | --------- | ---------- | ------- | ----- |
| Month 1  | €18.50    | €18.50     | ~€5     | ~€42  |
| Month 2+ | €18.50    | €18.50     | ~€5     | ~€42  |

**ROI**: Single €5000 project pays for 119 months of infrastructure.

---

_Last updated: 2026-02-01_
_Strategy: ThreeJS Specialist AI Assistant_
