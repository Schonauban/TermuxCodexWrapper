 # TermuxCodexWrapper

 > Wrapper Bash pour lancer et gérer des sessions OpenAI Codex (ChatGPT) dans Termux via un widget Android.

 ## Installation

 1. Clonez ce dépôt **TermuxCodexWrapper** dans votre répertoire Termux shortcuts :
    ```bash
    git clone git@github.com:VOTRE_UTILISATEUR/TermuxCodexWrapper.git ~/.shortcuts
    ```
 2. Rendez le script principal exécutable :
    ```bash
    chmod +x ~/.shortcuts/chatgpt
    ```
3. Lancez l'installateur pour configurer votre clé API et installer les dépendances :
   ```bash
   bash ~/.shortcuts/install.sh
   ```
    - Ce script vous demandera votre **OpenAI API Key**
    - Il la stockera dans `~/.shortcuts/.env` (ignoré par Git)
    - Il ajoutera également l’export dans votre `~/.bashrc` pour chargement automatique
 4. Rechargez votre configuration shell :
    ```bash
    source ~/.bashrc
    ```
 5. Ajoutez le widget à l’écran d’accueil Android :
    1. Appuyez longuement sur votre écran d’accueil
    2. Sélectionnez **Widgets** → **Termux Widget**
    3. Choisissez le script **chatgpt** (apparu dans `~/.shortcuts`)
    4. Un bouton sera créé : touchez-le pour lancer directement l’interface.

 ## Usage

 ```bash
 chatgpt list                # Liste les sessions existantes
 chatgpt new [NOM]           # Crée une nouvelle session
 chatgpt open NOM            # Reprend et continue une session existante
 chatgpt rename ANCIEN NOUVEAU  # Renomme une session
 chatgpt delete NOM          # Supprime une session
 chatgpt duplicate SRC DST   # Duplique une session
 chatgpt export [NOM]        # Exporte le script dans une session dédiée
 ```
  
### macOS
Pour installer la version macOS :
```bash
bash ~/.shortcuts/install_macos.sh
```
Ce script :
  - Installe Homebrew, Node.js et le CLI Codex
  - Crée un dossier `~/.codex-wrapper` et copie le script
  - Ajoute un raccourci dans `~/bin/chatgpt`
  - Configure votre clé OpenAI dans `~/.codex-wrapper/.env`
  - Met à jour votre `~/.bash_profile` ou `~/.zshrc`

### Linux
Vous pouvez également utiliser ce wrapper sur la plupart des distributions Linux :
```bash
# Clonez le dépôt
git clone git@github.com:Schonauban/TermuxCodexWrapper.git ~/.shortcuts

# Installez Node.js, npm et git (Debian/Ubuntu)
sudo apt update && sudo apt install -y nodejs npm git curl

# Installez le CLI Codex
npm install -g @openai/codex

# Préparez le wrapper
chmod +x ~/.shortcuts/chatgpt
mkdir -p ~/bin
ln -sf ~/.shortcuts/chatgpt ~/bin/chatgpt

# Configurez votre clé API
bash ~/.shortcuts/install.sh

# Rechargez votre shell
source ~/.bashrc  # ou ~/.zshrc
```

 ## Pousser sur votre dépôt Git

 Après avoir cloné et personnalisé **TermuxCodexWrapper** :
 ```bash
 cd ~/.shortcuts
 git remote add origin git@github.com:VOTRE_UTILISATEUR/TermuxCodexWrapper.git
 git branch -M main
 git push -u origin main
 ```

 **Attention** : ne commitez **jamais** votre clé OpenAI. Le fichier `.env` est ignoré par Git.