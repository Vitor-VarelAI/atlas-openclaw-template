---
name: search
description: Pesquisa na web via Brave Search API (FREE MODE - usar com moderação).
user-invocable: true
metadata: {"openclaw":{"emoji":"🔍","model":"default"}}
---

# Web Search - /search ⚠️ FREE MODE

Pesquisa na internet usando Brave Search API.

## ⚠️ AVISO: FREE MODE

```
Limite: 2000 queries/mês (~66/dia)
Custo: €0

USAR APENAS QUANDO:
✓ Info muito recente (últimos dias/semanas)
✓ Dados específicos não no treino do modelo
✓ URLs/links para recursos externos
✓ Preços/disponibilidade atual

NÃO USAR PARA:
✗ Info que o modelo já sabe
✗ Conceitos/tutoriais gerais
✗ Documentação standard (ThreeJS, etc)
✗ Pesquisas "por curiosidade"
```

## Comando

```
/search [query]
```

## Exemplo

```
/search ThreeJS performance optimization 2026
/search best WebGL shaders for water effects
```

## Ação

Quando invocado, faz request à Brave Search API:

```bash
curl -s "https://api.search.brave.com/res/v1/web/search?q=QUERY&count=5" \
  -H "X-Subscription-Token: $BRAVE_API_KEY"
```

## Formato de Resposta

```
🔍 Resultados para: "ThreeJS performance"

1. [Título do resultado](url)
   Descrição breve...

2. [Título do resultado](url)
   Descrição breve...

...
```

## Configuração

- **API Key**: `BRAVE_API_KEY` no `.env`
- **Free Tier**: 2000 queries/mês
- **Endpoint**: `https://api.search.brave.com/res/v1/web/search`

## Obter API Key

1. Vai a https://api.search.brave.com/app/keys
2. Cria conta ou faz login
3. Subscreve ao Free plan
4. Gera uma API key
5. Adiciona ao `.env`: `BRAVE_API_KEY=BSA...`

## Linguagem

Output em Português PT-PT.
