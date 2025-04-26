#!/data/data/com.termux/files/usr/bin/env bash
# Installation script for TermuxCodexWrapper (Termux widget)
set -e

# Directory of the widget scripts
SHORTCUTS_DIR="$HOME/.shortcuts"
ENV_FILE="$SHORTCUTS_DIR/.env"

echo
echo "=== Installation de TermuxCodexWrapper pour Termux ==="

# Ensure shortcuts directory exists
mkdir -p "$SHORTCUTS_DIR"

# Install dependencies if missing
echo "Vérification des dépendances..."
# Install Codex CLI
if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI introuvable. Installation en cours..."
  # Ensure npm (Node.js) is available
  if ! command -v npm >/dev/null 2>&1; then
    echo "npm introuvable. Installation de Node.js via pkg..."
    pkg install nodejs -y
  fi
  echo "Installation de @openai/codex via npm..."
  npm install -g @openai/codex
  echo "Codex CLI installé."
fi
# Install Termux widget dependencies
if ! pkg list-installed | grep -q termux-widget; then
  echo "Installation de termux-widget et termux-api..."
  pkg install termux-widget termux-api -y
fi
echo "Dépendances configurées."

# Prompt for OpenAI API key
read -p "Entrez votre clé OpenAI (non partagée, stockée en local): " api_key
if [ -z "$api_key" ]; then
  echo "Aucune clé fournie. Annulation."
  exit 1
fi

# Save to local env file
cat > "$ENV_FILE" <<EOF
export OPENAI_API_KEY=$api_key
EOF
chmod 600 "$ENV_FILE"
echo "Clé OpenAI enregistrée dans $ENV_FILE"

# Append export to ~/.bashrc if absent
if ! grep -q "OPENAI_API_KEY" "$HOME/.bashrc"; then
  echo "export OPENAI_API_KEY=$api_key" >> "$HOME/.bashrc"
  echo "Export ajouté à ~/.bashrc"
fi

echo
echo "Installation terminée."
echo "Ré-ouvrez Termux ou exécutez 'source ~/.bashrc' pour charger votre clé."
echo "Vous pouvez maintenant ajouter le widget à l'écran d'accueil Android :"
echo "  • Appuyez longuement sur l'écran d'accueil, choisissez Widgets → Termux Widget → script 'chatgpt'."
echo
exit 0