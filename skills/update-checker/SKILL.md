---
name: update
description: Verifica atualizações do OpenClaw upstream e mostra changelog.
user-invocable: true
metadata: {"openclaw":{"emoji":"🔄","priority":"system"}}
---

# Update Checker - /update

Verifica se existem atualizações do OpenClaw upstream.

## Comando

```
/update
```

## Ação

Quando invocado, executa:

```bash
./skills/update-checker/check-update.sh
```

## Formato de Resposta

```
🔄 ATLAS Update Check

Versão local:  v2026.1.30 (dab7fa1)
Versão upstream: v2026.2.1 (d842b28)

📦 2 atualizações disponíveis:

• 991ed3ab - Tests: stub SSRF DNS pinning
• 5676a6b3 - Docs: normalize zh-CN terminology

🔐 Security fixes incluídos: Sim

Para atualizar:
git fetch upstream && git merge v2026.2.1
```

## Linguagem

Output em Português PT-PT.
