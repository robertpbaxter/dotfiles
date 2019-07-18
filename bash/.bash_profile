#-----Config-----#

# Node
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# List documents in a single row
alias ls="ls -l"
alias lsa="ls -al"

#-----Shortcuts-----#

# Git
alias gcd="git checkout develop"

# nvm
export NVM_DIR=~/.nvm
source /usr/local/opt/nvm/nvm.sh
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# gg aliases
REPO_DIR="$HOME/gg"
GG_DIR="$REPO_DIR/GG"
CLIENT_DIR="$REPO_DIR/client"
SERVER_DIR="$REPO_DIR/server"
STYLE_DIR="$REPO_DIR/style"
ggg() { cd "$REPO_DIR/gg" }
ggc() { cd "$REPO_DIR/client" }
ggs() { cd "$REPO_DIR/server" }
ggup() { (cd "$GG_DIR/gg-local-infrastructure" && vagrant up) }
ggdown() { (cd "$GG_DIR/gg-local-infrastructure" && vagrant halt) }
ggrmemails ()
{
    du -sh /var/tmp/emails
    ls -1 /var/tmp/emails | wc -l
    find /var/tmp/emails -type f \( -iname '*.json' -o -iname '*.html' \) -exec rm '{}' +
  }

# personal aliases
ggi() { (cd "$CLIENT_DIR" && npm i) }
ggdev() { (cd "$CLIENT_DIR" && nvim) }
ggstyle() { (cd "$STYLE_DIR" && npx serve) }
buildprod(){ npm run build -- -e production -a false false NODE_EXTRA_CA_CERTS=~/gg/client/ssl/mkcert.rootCA.pem && npm run serve development }
