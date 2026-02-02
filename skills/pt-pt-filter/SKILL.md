---
name: pt-pt-filter
description: Filtro de normalização linguística PT-BR para PT-PT em todos os outputs.
user-invocable: false
metadata: {"openclaw":{"emoji":"🇵🇹","type":"post-processor","always":true}}
---

# PT-PT Filter - Language Normalization Layer

Camada de normalização que converte Português do Brasil para Português de Portugal.

## Propósito

Todos os modelos AI são treinados com 20:1 a 50:1 ratio PT-BR:PT-PT.
Este filtro corrige automaticamente Brazilianismos no output.

## Ativação

**SEMPRE ATIVO** - processa todos os outputs antes de entregar ao utilizador.

## Padrões de Substituição

### 1. Gerúndio → Infinitivo
```
PT-BR: "estou fazendo", "estava trabalhando"
PT-PT: "estou a fazer", "estava a trabalhar"

Regex: estou (\w+)ndo → estou a $1r
```

### 2. Pronomes Proclíticos → Enclíticos
```
PT-BR: "me dá", "te disse", "lhe falei"
PT-PT: "dá-me", "disse-te", "falei-lhe"

Regex: ^(me|te|lhe|nos) (\w+) → $2-$1
```

### 3. Vocabulário
```
PT-BR          PT-PT
────────────────────────
tela           ecrã
celular        telemóvel
ônibus         autocarro
café da manhã  pequeno-almoço
banheiro       casa de banho
você           tu (implícito)
legal          fixe/porreiro
```

### 4. Ortografia
```
PT-BR          PT-PT
────────────────────────
fato           facto
projeto        projecto (opcional)
ideia          ideia (sem diferença)
```

## Upgrade Futuro

**Project Amália** (Junho 2026)
- LLM soberano Português
- €5.5M investimento governo
- Native PT-PT, sem necessidade de filtro
- Integração planeada quando API pública

## Logging

Log todos os padrões matched para:
1. Melhorar regex patterns
2. Identificar novos Brazilianismos
3. Medir eficácia do filtro

## Notas Técnicas

- Aplicar DEPOIS do modelo responder
- Não modificar código (apenas texto)
- Preservar formatação markdown
- Cuidado com false positives em nomes próprios
