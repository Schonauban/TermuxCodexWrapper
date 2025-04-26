#!/data/data/com.termux/files/usr/bin/env bash
# Installation script for TermuxCodexWrapper (Termux widget)
set -e

# Directory of the widget scripts
SHORTCUTS_DIR="$HOME/.shortcuts"
##_ENV_FILE="$SHORTCUTS_DIR/.env"  # no longer used

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


echo
echo "Installation terminée."
echo "Relancez Termux pour charger les dépendances installées."
echo "Vous pouvez maintenant ajouter le widget à l'écran d'accueil Android :"
echo "  • Appuyez longuement sur l'écran d'accueil, choisissez Widgets → Termux Widget → script 'chatgpt'."
echo
exit 0