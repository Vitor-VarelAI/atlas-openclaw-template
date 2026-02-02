---
name: research-swarm
description: Pesquisa paralela com múltiplos agentes para análise competitiva e market research.
user-invocable: true
metadata: {"openclaw":{"emoji":"🔍","model":"synthetic/kimi-k2.5","mode":"swarm"}}
---

# Research Swarm - Parallel Agent System

Pesquisa multi-source usando 100 agentes paralelos (Kimi PARL architecture).

## Modelo

**Kimi K2.5 Swarm Mode** via Synthetic.new
- Parallel-Agent Reinforcement Learning (PARL)
- 100 sub-agentes concorrentes
- Ideal para pesquisa multi-fonte

## Triggers

Keywords que ativam este skill:
- `research`, `pesquisa`, `pesquisar`
- `compare`, `compara`, `comparar`
- `analyze`, `analisa`, `analisar`
- `top 10`, `melhores`, `alternatives`
- `market research`, `competitor analysis`

## Casos de Uso

### 1. Análise Competitiva
```
"Compara React Three Fiber vs vanilla Three.js vs Babylon.js"
```
Output: Tabela comparativa, prós/contras, recomendação

### 2. Market Research
```
"Top 10 ThreeJS libraries para efeitos de partículas 2026"
```
Output: Lista ranqueada com descrições, links, use cases

### 3. Tendências
```
"Quais são as tendências em WebGL/WebGPU para 2026?"
```
Output: Análise de tendências com fontes

## Estrutura de Output

```
📊 RESEARCH: [Tópico]

SUMÁRIO:
[2-3 frases principais]

ANÁLISE DETALHADA:
| Critério | Opção A | Opção B | Opção C |
|----------|---------|---------|---------|
| ...      | ...     | ...     | ...     |

FONTES:
- [Link 1]
- [Link 2]

RECOMENDAÇÃO:
[Conclusão acionável]
```

## Regras

1. Sempre citar fontes
2. Estruturar output em tabelas quando possível
3. Incluir recomendação final
4. PT-PT obrigatório
5. Foco em informação acionável

## Linguagem

**OBRIGATÓRIO**: Output em PT-PT
