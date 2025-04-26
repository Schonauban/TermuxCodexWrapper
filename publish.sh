#!/data/data/com.termux/files/usr/bin/env bash
# Publish the TermuxCodexWrapper repository to GitHub
set -e

# Configuration
REPO_NAME="TermuxCodexWrapper"
GITHUB_USER="Schonauban"

# Obtain GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
  read -s -p "GitHub Personal Access Token: " GITHUB_TOKEN
  echo
fi
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Token GitHub requis. Annulation."
  exit 1
fi

echo "Création du dépôt GitHub $GITHUB_USER/$REPO_NAME..."
curl -s -H "Authorization: token $GITHUB_TOKEN" \
     -d "{\"name\": \"$REPO_NAME\"}" \
     https://api.github.com/user/repos

echo "Configuration du dépôt local et push..."
cd "$HOME/.shortcuts"
# Initialize git repo if not already
git init
git add .
git commit -m "Publish TermuxCodexWrapper to GitHub" || true
# Add or update remote with token for push
REMOTE_URL_WITH_TOKEN="https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"
git remote remove origin 2>/dev/null || true
git remote add origin "$REMOTE_URL_WITH_TOKEN"

echo "Pushing main branch..."
git push -u origin main

echo "Nettoyage du remote origin pour enlever le token..."
git remote set-url origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo "Terminé. Le dépôt est disponible sur https://github.com/$GITHUB_USER/$REPO_NAME"
echo "Remote origin mis à jour sans token."