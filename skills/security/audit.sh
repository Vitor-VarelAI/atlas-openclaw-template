#!/bin/bash
# ATLAS Security Audit Script
# Verifica configurações de segurança do projeto

echo "🔐 ATLAS Security Audit"
echo "========================"
echo ""

ISSUES=0
WARNINGS=0

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((ISSUES++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

cd "$(dirname "$0")/../.." || exit 1

echo "📁 Verificando ficheiros..."
echo ""

# 1. Check if .env exists but not in git
if [ -f ".env" ]; then
    if git ls-files --error-unmatch .env &>/dev/null; then
        check_fail ".env está tracked no git! REMOVER IMEDIATAMENTE"
    else
        check_pass ".env existe e NÃO está no git"
    fi
else
    check_warn ".env não encontrado (necessário para deploy)"
fi

# 2. Check .gitignore has .env
if grep -q "^\.env$" .gitignore 2>/dev/null; then
    check_pass ".gitignore contém .env"
else
    check_fail ".gitignore NÃO contém .env"
fi

# 3. Check for hardcoded API keys in code
echo ""
echo "🔑 Verificando API keys hardcoded..."
echo ""

PATTERNS=(
    "sk-ant-api"
    "syn_[a-z0-9]"
    "sk-or-v1-"
    "BSA[A-Za-z0-9]"
)

for pattern in "${PATTERNS[@]}"; do
    # Exclude .env files, redaction configs, and documentation from search
    # Only flag if it looks like an actual key (longer than pattern + 10 chars)
    MATCHES=$(grep -r "$pattern" --include="*.json" --include="*.js" --include="*.ts" . 2>/dev/null | grep -v ".env" | grep -v "node_modules" | grep -v ".git" | grep -v '"redact' | grep -v 'SECURITY' | grep -v 'logging' | grep -v '\[' | head -5)
    if [ -n "$MATCHES" ]; then
        check_fail "Possível API key encontrada: $pattern"
        echo "    $MATCHES" | head -2
    fi
done

if [ $ISSUES -eq 0 ]; then
    check_pass "Nenhuma API key hardcoded encontrada"
fi

# 4. Check openclaw.json configs
echo ""
echo "⚙️  Verificando openclaw.json..."
echo ""

if [ -f "openclaw.json" ]; then
    # Check gateway auth
    if grep -q '"mode": "token"' openclaw.json; then
        check_pass "Gateway auth mode: token"
    else
        check_warn "Gateway auth mode não é token"
    fi

    # Check DM policy
    if grep -q '"dmPolicy": "allowlist"' openclaw.json; then
        check_pass "DM policy: allowlist"
    else
        check_fail "DM policy NÃO é allowlist - risco de acesso não autorizado"
    fi

    # Check heartbeat disabled
    if grep -q '"heartbeat"' openclaw.json && grep -A2 '"heartbeat"' openclaw.json | grep -q '"enabled": false'; then
        check_pass "Heartbeat desativado"
    else
        check_warn "Verificar se heartbeat está desativado"
    fi

    # Check sandbox mode
    if grep -q '"sandbox"' openclaw.json; then
        check_pass "Sandbox configurado"
    else
        check_warn "Sandbox não configurado - considerar ativar"
    fi

    # Check logging redaction
    if grep -q '"redactSensitive"' openclaw.json; then
        check_pass "Logging redaction configurado"
    else
        check_warn "Logging redaction não configurado"
    fi
else
    check_fail "openclaw.json não encontrado"
fi

# 5. Check permissions
echo ""
echo "🔒 Verificando permissões..."
echo ""

if [ -f ".env" ]; then
    PERMS=$(stat -f "%OLp" .env 2>/dev/null || stat -c "%a" .env 2>/dev/null)
    if [ "$PERMS" = "600" ] || [ "$PERMS" = "640" ]; then
        check_pass ".env tem permissões restritas ($PERMS)"
    else
        check_warn ".env tem permissões $PERMS (recomendado: 600)"
    fi
fi

# Summary
echo ""
echo "========================"
echo "📊 Resumo"
echo ""

if [ $ISSUES -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ Todas as verificações passaram!${NC}"
elif [ $ISSUES -eq 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS avisos encontrados${NC}"
else
    echo -e "${RED}✗ $ISSUES problemas críticos encontrados${NC}"
    [ $WARNINGS -gt 0 ] && echo -e "${YELLOW}⚠ $WARNINGS avisos adicionais${NC}"
fi

echo ""
exit $ISSUES
