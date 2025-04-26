#!/usr/bin/env bash
# install_macos.sh: Installation du wrapper TermuxCodexWrapper sur macOS
set -e

echo "=== Installation TermuxCodexWrapper (macOS) ==="

# Vérifier Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew non trouvé. Installation de Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Installer Node.js si nécessaire
if ! command -v node >/dev/null 2>&1; then
  echo "Installation de Node.js via Homebrew..."
  brew install node
fi

# Installer Codex CLI
if ! command -v codex >/dev/null 2>&1; then
  echo "Installation de @openai/codex CLI..."
  npm install -g @openai/codex
fi

# Créer dossier pour le wrapper
WRAPPER_DIR="$HOME/.codex-wrapper"
echo "Création du dossier wrapper: $WRAPPER_DIR"
mkdir -p "$WRAPPER_DIR"
# Créer dossier de sessions pour macOS/Linux
SESS_DIR="$HOME/.TermuxCodexWrapper/sessions"
echo "Création du dossier de sessions: $SESS_DIR"
mkdir -p "$SESS_DIR"

# Copier le script chatgpt
SCRIPT_SRC="$(dirname "$0")/chatgpt"
ln -sf "$SCRIPT_SRC" "$WRAPPER_DIR/chatgpt"

# Ajouter ~/bin si nécessaire
if [ ! -d "$HOME/bin" ]; then mkdir -p "$HOME/bin"; fi
ln -sf "$WRAPPER_DIR/chatgpt" "$HOME/bin/chatgpt"

## Note: API key will be requested by Codex CLI on first usage

echo "Installation terminée."
echo "Relancez votre terminal ou exécutez: source $SHELL_RC"
echo "Vous pouvez lancer la commande 'chatgpt' pour utiliser le wrapper."
exit 0