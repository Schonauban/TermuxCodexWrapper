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

# Clé API OpenAI
ENV_FILE="$WRAPPER_DIR/.env"
read -p "Entrez votre clé OpenAI (sera stockée dans $ENV_FILE): " api_key
cat > "$ENV_FILE" <<EOF
export OPENAI_API_KEY=$api_key
EOF
chmod 600 "$ENV_FILE"

# Ajouter sourcing dans shell rc
SHELL_RC="$HOME/.bash_profile"
[ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"
if ! grep -q "codex-wrapper" "$SHELL_RC"; then
  echo "source $ENV_FILE  # codex-wrapper" >> "$SHELL_RC"
  echo "Ajouté '$ENV_FILE' à $SHELL_RC"
fi

echo "Installation terminée."
echo "Relancez votre terminal ou exécutez: source $SHELL_RC"
echo "Vous pouvez lancer la commande 'chatgpt' pour utiliser le wrapper."
exit 0