#!/bin/bash
# Verifica quota Synthetic.new e retorna status formatado
# Uso: ./check-quota.sh [json|text|context]

FORMAT="${1:-text}"
API_KEY="${SYNTHETIC_API_KEY}"

if [ -z "$API_KEY" ]; then
    echo "Erro: SYNTHETIC_API_KEY não definida"
    exit 1
fi

# Fetch quota
QUOTA=$(curl -s "https://api.synthetic.new/v2/quotas" -H "Authorization: Bearer $API_KEY")

if [ -z "$QUOTA" ] || echo "$QUOTA" | grep -q "error"; then
    echo "Erro ao obter quota"
    exit 1
fi

# Parse values
SUB_USED=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['subscription']['requests'])")
SUB_LIMIT=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['subscription']['limit'])")
SUB_RENEWS=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['subscription']['renewsAt'])")

TOOL_USED=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('toolCallDiscounts',{}).get('requests',0))")
TOOL_LIMIT=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('toolCallDiscounts',{}).get('limit',0))")

SEARCH_USED=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('search',{}).get('hourly',{}).get('requests',0))")
SEARCH_LIMIT=$(echo "$QUOTA" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('search',{}).get('hourly',{}).get('limit',0))")

# Calculate percentages
SUB_PCT=$(python3 -c "print(round($SUB_USED/$SUB_LIMIT*100, 1))")
TOOL_PCT=$(python3 -c "print(round($TOOL_USED/$TOOL_LIMIT*100, 1) if $TOOL_LIMIT > 0 else 0)")

# Determine status
if (( $(echo "$SUB_PCT > 95" | bc -l) )); then
    STATUS="BLOCKED"
    EMOJI="⛔"
    ADVICE="Aguarda pelo reset antes de continuar"
elif (( $(echo "$SUB_PCT > 85" | bc -l) )); then
    STATUS="CRITICAL"
    EMOJI="🔴"
    ADVICE="Minimiza tokens, respostas curtas"
elif (( $(echo "$SUB_PCT > 60" | bc -l) )); then
    STATUS="WARNING"
    EMOJI="🟡"
    ADVICE="Prefere respostas concisas"
else
    STATUS="OK"
    EMOJI="🟢"
    ADVICE="Operação normal"
fi

# Calculate time until renewal
RENEW_SECS=$(python3 -c "
from datetime import datetime, timezone
renews = datetime.fromisoformat('$SUB_RENEWS'.replace('Z','+00:00'))
now = datetime.now(timezone.utc)
diff = renews - now
hours = int(diff.total_seconds() // 3600)
mins = int((diff.total_seconds() % 3600) // 60)
print(f'{hours}h {mins}min')
")

case "$FORMAT" in
    json)
        echo "$QUOTA"
        ;;
    context)
        # Format for AI system context injection
        echo "QUOTA_STATUS: $SUB_USED/$SUB_LIMIT ($SUB_PCT%) - $EMOJI $STATUS - renova em $RENEW_SECS"
        echo "TOOL_CALLS: $TOOL_USED/$TOOL_LIMIT ($TOOL_PCT%)"
        echo "RECOMENDAÇÃO: $ADVICE"
        ;;
    *)
        # Human-readable format for Telegram
        echo "📊 Uso Synthetic (Standard)"
        echo ""
        echo "Subscription: $SUB_USED/$SUB_LIMIT ($SUB_PCT%)"
        echo "├─ Renova: $RENEW_SECS"
        echo "└─ Estado: $EMOJI $STATUS"
        echo ""
        echo "Tool Calls: $TOOL_USED/$TOOL_LIMIT ($TOOL_PCT%)"
        echo "Search: $SEARCH_USED/$SEARCH_LIMIT/hora"
        echo ""
        echo "💡 $ADVICE"
        ;;
esac
