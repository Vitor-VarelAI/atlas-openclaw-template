---
name: cost
description: Verifica o uso de quota da API Synthetic.new e alerta sobre limites.
user-invocable: true
metadata: {"openclaw":{"emoji":"📊","priority":"system"}}
---

# Quota Monitor - /cost

Verifica o estado atual de uso da API Synthetic.new.

## Comando

```
/cost
```

## Ação

Quando invocado, executa:

```bash
curl -s "https://api.synthetic.new/v2/quotas" -H "Authorization: Bearer $SYNTHETIC_API_KEY"
```

## Formato de Resposta

Apresentar os dados em formato legível:

```
📊 Uso Synthetic (Standard)

Subscription: [usado]/[limite] ([%])
├─ Renova: [tempo restante]
└─ Estado: [🟢 OK | 🟡 Atenção (>60%) | 🔴 Crítico (>85%)]

Tool Calls: [usado]/[limite] ([%])
Search: [usado]/[limite] ([%])
```

## Níveis de Alerta

| Uso | Estado | Comportamento |
|-----|--------|---------------|
| 0-60% | 🟢 OK | Normal |
| 60-85% | 🟡 Atenção | Preferir respostas concisas |
| 85-95% | 🔴 Crítico | Avisar utilizador, minimizar tokens |
| >95% | ⛔ Bloqueado | Sugerir esperar pelo reset |

## Integração de Sistema

Este skill também injeta contexto de uso no sistema. Quando o assistente responde, deve ter consciência de:

1. **Uso atual** - Para ajustar verbosidade das respostas
2. **Tempo até reset** - Para planear tarefas longas
3. **Tool call budget** - Para decidir uso de ferramentas

## Exemplo de Contexto Injetado

```
QUOTA_STATUS: 45/135 (33%) - 🟢 OK - renova em 3h 15min
TOOL_CALLS: 120/1620 (7%) - ampla margem
RECOMENDAÇÃO: Operação normal, sem restrições
```

## Linguagem

Output em Português PT-PT.
