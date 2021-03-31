#-----Config-----#

# nvim as default
alias vim=nvim
alias vi=nvim
export EDITOR=nvim
export GIT_EDITOR=nvim

# Node
export PATH="$HOME/.yarn/bin:usr/local/opt/perl/bin:/usr/sbin:usr/local/bin:/Library/PostgreSQL/11/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# FZF exclude node modules
export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,src/greenlight/node_modules/*,.git/*}"'

# List documents in a single row
alias ls="ls -l"
alias lsa="ls -al"

#-----Shortcuts-----#

# Git
alias gcd="git checkout develop"
alias gcb="git checkout -b"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# gg aliases
REPO_DIR="$HOME/gg"
GG_DIR="$REPO_DIR/GG"
CLIENT_DIR="$REPO_DIR/client"
SERVER_DIR="$REPO_DIR/greenlight-server"
SERVER_JC_DIR="$REPO_DIR/gg-java-common"
SERVER_AH_DIR="$REPO_DIR/gg-activityhistory-service"
SERVER_AUTHZ_DIR="$REPO_DIR/gg-authz-service"
SERVER_REPO_DIR="$REPO_DIR/gg-repo-service"

# directory shortcuts
ggg() { cd "$GG_DIR" }
ggc() { cd "$CLIENT_DIR" }

ggjc() {
  if [ ! $# = 1 ]; then
    cd "$SERVER_JC_DIR"
  else
    (cd "$SERVER_JC_DIR"; ./gg.sh $@)
  fi
}

ggs() {
  if [ ! $# = 1 ]; then
    cd "$SERVER_DIR"
  else
    (cd "$SERVER_DIR"; ./gg.sh $@)
  fi
}

ggah() {
  if [ ! $# = 1 ]; then
    cd "$SERVER_AH_DIR"
  else
    (cd "$SERVER_AH_DIR"; ./gg.sh $@)
  fi
}

ggauth() {
  if [ ! $# = 1 ]; then
    cd "$SERVER_AUTHZ_DIR"
  else
    (cd "$SERVER_AUTHZ_DIR"; ./gg.sh $@)
  fi
}

ggrepo() {
  if [ ! $# = 1 ]; then
    cd "$SERVER_REPO_DIR"
  else
    (cd "$SERVER_REPO_DIR"; ./gg.sh $@)
  fi
}

ggkey() { (cd "$GG_DIR/local/aws"; ./get_mvn_token.sh; source ~/.bash_profile;) }

docker-status() { (cd "$GG_DIR/local/docker"; ./gg.sh Status); }
start-docker() { (cd "$GG_DIR/local/docker"; ./gg.sh Start); }
stop-docker() { (cd "$GG_DIR/local/docker"; ./gg.sh Stop); }
update-docker() { (cd "$GG_DIR/local/docker"; ./gg.sh Stop && git pull && ./gg.sh Start); }

# clear emails
ggrmemails ()
{
    du -sh /var/tmp/emails
    ls -1 /var/tmp/emails | wc -l
    find /var/tmp/emails -type f \( -iname '*.json' -o -iname '*.html' \) -exec rm '{}' +
  }

# local tomcat server
alias start-tomcat="/opt/gg/tomcat/bin/startup.sh"
alias stop-tomcat="/opt/gg/tomcat/bin/shutdown.sh"

# access psql server
db_analytics(){ (psql "dbname=analytics host=localhost user=ggadmin password=ggpass port=5432") }

# Maven config for AWS
source ~/.codeartifact_mvn_auth
