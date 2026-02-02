#!/bin/bash
# Pesquisa na web via Brave Search API
# Uso: ./search.sh "query"

QUERY="$1"
API_KEY="${BRAVE_API_KEY}"

if [ -z "$API_KEY" ]; then
    echo "❌ Erro: BRAVE_API_KEY não definida no .env"
    echo ""
    echo "Para configurar:"
    echo "1. Vai a https://api.search.brave.com/app/keys"
    echo "2. Cria/obtém a tua API key"
    echo "3. Adiciona ao .env: BRAVE_API_KEY=BSA..."
    exit 1
fi

if [ -z "$QUERY" ]; then
    echo "Uso: ./search.sh \"query\""
    exit 1
fi

# URL encode the query
ENCODED_QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$QUERY'))")

# Make the search request
RESPONSE=$(curl -s "https://api.search.brave.com/res/v1/web/search?q=$ENCODED_QUERY&count=5" \
    -H "Accept: application/json" \
    -H "X-Subscription-Token: $API_KEY")

# Check for errors
if echo "$RESPONSE" | grep -q '"error"'; then
    echo "❌ Erro na pesquisa:"
    echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('error',{}).get('message','Unknown error'))"
    exit 1
fi

# Parse and format results
echo "🔍 Resultados para: \"$QUERY\""
echo ""

echo "$RESPONSE" | python3 -c "
import sys
import json

data = json.load(sys.stdin)
results = data.get('web', {}).get('results', [])

if not results:
    print('Nenhum resultado encontrado.')
else:
    for i, r in enumerate(results[:5], 1):
        title = r.get('title', 'Sem título')
        url = r.get('url', '')
        desc = r.get('description', '')[:150]
        print(f'{i}. {title}')
        print(f'   {url}')
        if desc:
            print(f'   {desc}...')
        print()
"
