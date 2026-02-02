# Claude Code Guidelines - ThreeJS Specialist AI Assistant

## Core Operating Principles (Boris Cherny's 10 Tips)

### 1. Plan Mode First

- Start complex tasks in plan mode (`/plan` or EnterPlanMode tool)
- Invest in strong plans so implementation can be 1-shot
- If things go sideways → switch back to plan mode and re-plan

### 2. Use Subagents Liberally

- Append "use subagents" to throw more compute at hard problems
- Offload subtasks to keep main context clean/focused

### 3. Strong Verification Loops

- Always run tests after code changes
- Use bash checks to verify behavior
- Verify changes work before marking complete

### 4. Update Docs After Corrections

- When user corrects a mistake, update this file or project docs
- Track patterns of errors to prevent recurrence

### 5. Explain the "Why"

- Provide reasoning behind changes, not just what changed
- Use ASCII diagrams for complex systems

### 6. Quality Bar

- Hold Claude-written code to human standards
- No shortcuts on error handling or edge cases

### 7. Test-First Bug Fixing

- **NEVER start by trying to fix a bug directly**
- First, write a test that reproduces the bug
- Then use subagents to attempt fixes in parallel
- Prove the fix with a passing test
- Point to logs, failing tests, or bug threads for context

### 8. Low-Ambiguity Specs

- Ask clarifying questions upfront rather than guess
- Write detailed specs before implementation

### 9. Parallel Worktrees

- Use git worktrees for parallel development
- Keep analysis/debugging separate from implementation

### 10. Skills & Reusable Patterns

- If doing something >1x/day → create a skill
- Check `/skills` directory for existing patterns

---

## Architecture Overview

### Multi-Tier Routing System

```
┌─────────────────────────────────────────────────────────────┐
│                    USER REQUEST (Telegram)                   │
│                   Portuguese PT-PT Interface                 │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              TIER 0: PT-PT LANGUAGE LAYER                   │
│                                                             │
│   Current: DeepSeek V3 + PT-BR→PT-PT regex filter          │
│   Future:  Project Amália (June 2026)                       │
│                                                             │
│   ALL Portuguese output normalized to PT-PT                 │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              TIER 1: COMMODITY WORKERS (85%)                │
│                                                             │
│   DeepSeek V3.2 (159k ctx): General text, backend code     │
│   Qwen 3 VL (250k ctx): Basic vision, image analysis       │
│                                                             │
│   Cost: $0 (included in Synthetic Standard $20/mo)         │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│          TIER 2: VISUAL AGENTIC SPECIALIST (10%)            │
│                                                             │
│   Kimi K2.5 (256k ctx, 1T params):                         │
│   - ThreeJS / WebGL / Shaders                              │
│   - Frontend code generation                                │
│   - UI debugging from screenshots                           │
│   - Research swarms (100 parallel agents)                   │
│                                                             │
│   Cost: $0 (included in Synthetic!)                        │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│            TIER 3: QUALITY VALIDATOR (5%)                   │
│                                                             │
│   Claude 4.5 Sonnet via setup-token                        │
│   - Final validation for critical tasks                     │
│   - High-stakes accuracy verification                       │
│                                                             │
│   Cost: $0 (uses existing Claude Pro subscription)         │
└─────────────────────────────────────────────────────────────┘
```

### Routing Rules

| Trigger                                                         | Route To      | Reason             |
| --------------------------------------------------------------- | ------------- | ------------------ |
| "threejs", "three.js", "3d", "webgl", "shader", "scene", "mesh" | Kimi K2.5     | Visual specialist  |
| "research", "compare", "analyze", "top 10", multiple sources    | Kimi Swarm    | Parallel agents    |
| Image upload + "UI" / "design" / "screenshot"                   | Kimi K2.5     | Visual debugging   |
| Image upload (other)                                            | Qwen 3 VL     | Basic vision       |
| "verify", "critical", "importante", manual escalation           | Claude 4.5    | Quality validation |
| Default / simple queries                                        | DeepSeek V3.2 | Fast, cheap        |

---

## Project-Specific Context

### What This Project Is

**ATLAS** - Telegram-based AI assistant for **ThreeJS/3D web development freelancing**:

- **Primary**: ThreeJS code generation (€5000+ projects)
- **Secondary**: Research & competitive analysis via agent swarms
- **Tertiary**: Vision processing, design-to-code workflows
- **Interface**: Telegram (text only, PT-PT)

### User Profile

- **Name**: Vitor
- **Location**: Queluz, Lisboa, Portugal (Europe/Lisbon)
- **Work**: Freelance ThreeJS/3D web developer
- **Project Value**: €5000+ minimum per project
- **Schedule**: Night shifts (21h-06h), remote
- **Language**: Portuguese PT-PT (CRITICAL - NOT Brazilian!)

### Active Projects

1. **ThreeJS Freelance** - Premium 3D web development (PRIMARY)
2. ExaSignal - Polymarket trading signals (Python/FastAPI)
3. KineticAI - Biomechanics Vision AI (AWS competition)

### Budget: €42/month Total

| Component              | Cost          | Purpose                    |
| ---------------------- | ------------- | -------------------------- |
| Synthetic.new Standard | €18.50 ($20)  | 19 models incl. Kimi K2.5  |
| Claude Pro             | €18.50 ($20)  | Validation via setup-token |
| Railway                | ~€5           | Bot hosting                |
| **Total**              | **€42/month** |                            |

### ROI

- Infrastructure: €42/month
- Single project revenue: €5000+
- Break-even: 0.0084 projects
- Time savings: ThreeJS scenes 5 min vs 8 hours (96x)

---

## PT-PT Language Quality (CRITICAL)

### Why This Matters

Global models trained 20:1 to 50:1 PT-BR:PT-PT ratio. Output contains Brazilianisms by default.

### System Prompt (All Models)

```
OBRIGATÓRIO: Responde SEMPRE em Português de Portugal (PT-PT), NUNCA em Português do Brasil.

Regras linguísticas PT-PT:
- Gerúndio com "a + infinitivo" (ex: "estou a trabalhar", não "estou trabalhando")
- Pronomes enclíticos (ex: "diz-me", não "me diz")
- Vocabulário PT-PT: ecrã, autocarro, telemóvel, pequeno-almoço
- Tratamento: usa "tu" implícito ou formal, evita "você"
```

### Regex Filter Patterns

| Pattern    | PT-BR           | PT-PT           |
| ---------- | --------------- | --------------- |
| Gerund     | "estou fazendo" | "estou a fazer" |
| Proclitic  | "me dá"         | "dá-me"         |
| Vocabulary | "tela"          | "ecrã"          |
| Vocabulary | "ônibus"        | "autocarro"     |
| Vocabulary | "celular"       | "telemóvel"     |

### Future: Project Amália (June 2026)

- Portuguese sovereign LLM, €5.5M government investment
- Native PT-PT, no filtering needed
- Currently beta, public API expected June 2026
- Plan: Replace DeepSeek in language layer when available

---

## Kimi K2.5 Optimization

### ThreeJS Prompt Structure

```
TAREFA: [Clear, specific description]

CONTEXTO TÉCNICO:
- Three.js versão: r160+
- Renderer: WebGLRenderer
- Framework: [React Three Fiber / vanilla / etc]

REQUISITOS:
1. [Feature 1]
2. [Feature 2]

OUTPUT ESPERADO:
- Código completo e funcional
- Comentários em PT-PT
```

### When to Use Swarm vs Single

| Swarm Mode             | Single Agent             |
| ---------------------- | ------------------------ |
| Research: "top 10 X"   | Code generation          |
| Competitive analysis   | Debugging specific issue |
| Multi-source gathering | Single-focus task        |
| "Compare X vs Y vs Z"  | "Create X"               |

### 256k Context Strategy

- Don't dump everything - selective context better
- Scene definition at top
- Code blocks labeled clearly
- Prune history to last 3-5 exchanges

---

## Cost Controls (CRITICAL)

### Rate Limits

- Synthetic Standard: 135 req/5h base (~65/day)
- Small requests (<2048 tokens): 0.2x = ~325/day
- Tool calls: 0.1x = ~650/day

### Monitoring

- Alert at 80% daily limit (52 requests)
- Hard block at 95% (62 requests)
- Daily summary at 23:00

### Safety Settings

```json
{
  "heartbeat": { "enabled": false },
  "cron": { "enabled": false },
  "rateLimits": {
    "daily": { "maxCalls": 100, "maxTokens": 500000 }
  }
}
```

**NEVER enable heartbeat** - can cause €1000+/month costs!

---

## Project Structure

```
/Manager
├── CLAUDE.md           # This file - guidelines & architecture
├── WALKTHROUGH.md      # Strategic context & research
├── TASKS.md            # Implementation tasks by phase
├── DEPLOY.md           # Railway deployment guide
├── segurança.md        # Security documentation
├── openclaw.json       # Main configuration
├── .env.example        # Environment variables template
└── skills/
    ├── threejs-coder/      # ThreeJS code generation
    ├── research-swarm/     # Parallel research agent
    ├── pt-pt-filter/       # Language normalization
    ├── vision-analyzer/    # UI/design analysis
    └── security/           # ACIP prompt injection defense
```

---

## Implementation Phases

### Phase 1: Infrastructure Setup

- [ ] Subscribe to Synthetic.new Standard ($20/mo)
- [ ] Verify Kimi K2.5 access in Synthetic dashboard
- [ ] Create Telegram bot via @BotFather
- [ ] Generate Claude setup-token (`claude setup-token`)
- [ ] Deploy OpenClaw to Railway

### Phase 2: Routing Configuration

- [ ] Configure keyword-based routing rules
- [ ] Set up model fallback chain
- [ ] Test ThreeJS → Kimi routing
- [ ] Test Research → Swarm routing

### Phase 3: PT-PT Layer

- [ ] Implement regex filter for Brazilianisms
- [ ] Configure system prompts for all models
- [ ] Test Portuguese output quality
- [ ] Build pattern library from failures

### Phase 4: Production Hardening

- [ ] Set up rate limit monitoring
- [ ] Configure error handling & retries
- [ ] Enable logging (Railway + external)
- [ ] Test fallback scenarios

### Phase 5: Optimization

- [ ] Monitor for 1 week
- [ ] Tune routing rules based on usage
- [ ] Optimize PT-PT filter patterns
- [ ] Prepare for Amália integration (June 2026)

---

## Learned Patterns & Corrections

### 2026-02-01 - Cost Explosion Risk

**Problem**: Default OpenClaw config can cost €1000+/month (heartbeat every 30min)
**Rule**: ALWAYS disable heartbeat and cron initially.

### 2026-02-01 - PT-PT Language Quality

**Problem**: Models default to PT-BR due to training data imbalance
**Rule**: Every model needs PT-PT system prompt + output filter layer.

### 2026-02-01 - Kimi K2.5 Discovery

**Problem**: Initial architecture didn't account for visual/agentic specialist
**Rule**: Kimi K2.5 is optimal for ThreeJS/frontend - route visual tasks to it.

### 2026-02-02 - ACIP Prompt Injection Defense

**Problem**: Telegram bot vulnerable to prompt injection via malicious messages
**Rule**: Install ACIP Clawdbot integration in `skills/security/` for cognitive-level defense.

### 2026-02-02 - Test-First Bug Fixing Workflow

**Problem**: Jumping straight to fixing bugs without a reproducible test leads to incomplete fixes and regressions
**Rule**: When a bug is reported: (1) Write a failing test that reproduces it, (2) Use subagents to attempt fixes in parallel, (3) Only mark fixed when test passes.

### Template

```
### [Date] - [Issue Title]
**Problem**: What went wrong
**Rule**: What to do/avoid in future
```

---

## Quick Reference

### Telegram Commands

```
@kimi [prompt]     - Force Kimi K2.5
@deepseek [prompt] - Force DeepSeek
@claude [prompt]   - Force Claude validation
/cost              - Quota Synthetic ✓
/update            - Verificar atualizações ✓
/search [query]    - Pesquisa web (Brave) ✓ ⚠️ FREE MODE
/status            - System health (planned)
```

### /cost Output Example

```
📊 Uso Synthetic (Standard)

Subscription: 45/135 (33%)
├─ Renova: 3h 15min
└─ Estado: 🟢 OK

Tool Calls: 120/1620 (7%)
Search: 5/250/hora

💡 Operação normal
```

### Brave Search - FREE MODE ⚠️

```
Limite: 2000 queries/mês (~66/dia)
Custo: €0

REGRAS:
- Usar apenas quando NECESSÁRIO
- Preferir conhecimento interno primeiro
- Agrupar pesquisas relacionadas
- Não usar para info que o modelo já sabe
```

### Sistema de Alertas de Quota

| Uso | Estado | Comportamento do AI |
|-----|--------|---------------------|
| 0-60% | 🟢 OK | Normal |
| 60-85% | 🟡 Atenção | Respostas mais concisas |
| 85-95% | 🔴 Crítico | Info essencial apenas |
| >95% | ⛔ Bloqueado | Sugere aguardar reset |

### Emergency Stop

```
Railway Dashboard → Service → Stop
OR
Anthropic Console → Disable API key
```

---

_Last updated: 2026-02-02_
_Strategy: ThreeJS Specialist AI Assistant_
