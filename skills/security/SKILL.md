---
name: security
description: ACIP-based prompt injection defense and cognitive security layer
trigger: automatic (always loaded)
---

# Security Skill - ACIP Cognitive Inoculation

This skill provides prompt injection defense based on [ACIP v1.3](https://github.com/Dicklesworthstone/acip).

## Files

- **SECURITY.md** - Official ACIP Clawdbot integration (~1,200 tokens)
- **SECURITY.local.md** - Custom rules for this project

## What It Protects Against

1. **Prompt Injection** - Malicious instructions in messages, emails, web pages
2. **Data Exfiltration** - Attempts to extract secrets, API keys, configs
3. **Unauthorized Actions** - Mass messaging, destructive commands, file access

## Trust Boundaries

```
System rules > Owner (verified) > Messages > External content
```

## Maintenance

To update SECURITY.md to latest ACIP version:

```bash
curl -fsSL https://raw.githubusercontent.com/Dicklesworthstone/acip/main/integrations/clawdbot/SECURITY.md \
  -o skills/security/SECURITY.md
```

Verify checksum:

```bash
shasum -a 256 skills/security/SECURITY.md
```

---

_Based on ACIP v1.3 - https://github.com/Dicklesworthstone/acip_
