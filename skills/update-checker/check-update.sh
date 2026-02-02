#!/bin/bash
# Verifica atualizações do OpenClaw upstream
# Uso: ./check-update.sh

cd "$(dirname "$0")/../.." || exit 1

# Fetch upstream silently
git fetch upstream --tags -q 2>/dev/null

# Get versions
LOCAL_TAG=$(git describe --tags --always 2>/dev/null)
LOCAL_COMMIT=$(git rev-parse --short HEAD 2>/dev/null)
UPSTREAM_TAG=$(git describe --tags upstream/main 2>/dev/null)
UPSTREAM_COMMIT=$(git rev-parse --short upstream/main 2>/dev/null)

# Count commits behind
BEHIND=$(git rev-list HEAD..upstream/main --count 2>/dev/null)

echo "🔄 ATLAS Update Check"
echo ""
echo "Versão local:    $LOCAL_TAG ($LOCAL_COMMIT)"
echo "Versão upstream: $UPSTREAM_TAG ($UPSTREAM_COMMIT)"
echo ""

if [ "$BEHIND" -eq 0 ]; then
    echo "✅ ATLAS está atualizado!"
else
    echo "📦 $BEHIND atualizações disponíveis:"
    echo ""
    git log HEAD..upstream/main --oneline | head -10 | while read line; do
        echo "• $line"
    done

    if [ "$BEHIND" -gt 10 ]; then
        echo "• ... e mais $((BEHIND - 10)) commits"
    fi

    # Check for security fixes
    SECURITY=$(git log HEAD..upstream/main --oneline | grep -i -E "(security|fix/|CVE|vuln)" | wc -l | tr -d ' ')
    echo ""
    if [ "$SECURITY" -gt 0 ]; then
        echo "🔐 Security fixes incluídos: Sim ($SECURITY)"
    else
        echo "🔐 Security fixes incluídos: Não"
    fi

    echo ""
    echo "Para atualizar:"
    echo "git merge upstream/main"
    echo ""
    echo "Ou para versão específica:"
    echo "git merge $UPSTREAM_TAG"
fi
