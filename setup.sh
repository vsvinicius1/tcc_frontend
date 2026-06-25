#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# GestãoTCC — Script de configuração do frontend Rails
# ─────────────────────────────────────────────────────────────────────────────

set -e

echo ""
echo "╔══════════════════════════════════════╗"
echo "║       GestãoTCC — Setup Frontend     ║"
echo "╚══════════════════════════════════════╝"
echo ""

# 1. Verificar Ruby
if ! command -v ruby &> /dev/null; then
  echo "❌ Ruby não encontrado. Instale Ruby >= 3.1"
  echo "   → https://www.ruby-lang.org/pt/downloads/"
  exit 1
fi

RUBY_VERSION=$(ruby -v)
echo "✅ Ruby encontrado: $RUBY_VERSION"

# 2. Verificar / instalar bundler
if ! command -v bundle &> /dev/null; then
  echo "📦 Instalando bundler..."
  gem install bundler
fi

# 3. Instalar gems
echo ""
echo "📦 Instalando dependências (bundle install)..."
bundle install

# 4. Verificar backend
echo ""
echo "🔍 Verificando se o backend Django está rodando em http://127.0.0.1:8000..."
if curl -s --max-time 3 http://127.0.0.1:8000/api/ > /dev/null 2>&1; then
  echo "✅ Backend Django respondendo!"
else
  echo "⚠️  Backend não encontrado em http://127.0.0.1:8000"
  echo "   Certifique-se de iniciar o Django antes: python manage.py runserver"
  echo "   Você pode iniciar o frontend mesmo assim e o backend depois."
fi

# 5. Instruções finais
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✨ Tudo pronto! Para iniciar o servidor:"
echo ""
echo "   rails server"
echo "   # ou:  bin/rails server"
echo ""
echo "   Acesse: http://localhost:3000"
echo ""
echo "   Para usar um backend em outro endereço:"
echo "   API_BASE_URL=http://outro-host:8000/api rails server"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
