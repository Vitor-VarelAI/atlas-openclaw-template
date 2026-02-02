---
name: vision-analyzer
description: Análise visual de UI/design e debugging de interfaces a partir de screenshots.
user-invocable: true
metadata: {"openclaw":{"emoji":"👁️","model":"synthetic/kimi-k2.5"}}
---

# Vision Analyzer - UI/Design Analysis

Análise visual de interfaces e debugging a partir de screenshots.

## Modelos

**UI/Design** → Kimi K2.5 (visual specialist)
**Outras imagens** → Qwen 3 VL (basic vision)

## Triggers

### Routing para Kimi K2.5
- Imagem + `ui`, `design`, `screenshot`
- Imagem + `interface`, `layout`, `css`
- Imagem + `bug`, `glitch`, `broken`

### Routing para Qwen 3 VL
- Imagem sem keywords UI
- Análise básica de imagens

## Casos de Uso

### 1. UI Debugging
```
[Screenshot de UI quebrada]
"O que está errado com este layout?"
```
Output: Identificação do problema, sugestão de fix CSS

### 2. Design-to-Code
```
[Screenshot de design Figma]
"Converte este design para React component"
```
Output: Código React/JSX completo

### 3. Análise de Referência
```
[Screenshot de site competitor]
"Analisa a estrutura visual deste hero section"
```
Output: Breakdown técnico, tecnologias identificadas

## Estrutura de Output

### Para Debugging
```
🔍 ANÁLISE UI

PROBLEMA IDENTIFICADO:
[Descrição do issue]

CAUSA PROVÁVEL:
[Explicação técnica]

FIX SUGERIDO:
[Código CSS/JS]

PREVENÇÃO:
[Best practice para evitar no futuro]
```

### Para Design-to-Code
```
🎨 DESIGN → CODE

COMPONENTE: [Nome]

ESTRUTURA:
[Breakdown hierárquico]

CÓDIGO:
[Implementação completa]

NOTAS:
[Considerações de responsividade, etc]
```

## Regras

1. Sempre identificar tecnologias visíveis
2. Código output deve ser funcional
3. Incluir considerações de responsividade
4. PT-PT obrigatório
5. Sugerir improvements quando apropriado

## Linguagem

**OBRIGATÓRIO**: Output em PT-PT
