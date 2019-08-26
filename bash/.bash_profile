#-----Config-----#

# Node
export PATH="$HOME/.yarn/bin:/usr/sbin:/Library/PostgreSQL/11/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

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

# intelliJ
COMMON_OPTIONS=(-Dgreenlight.application.properties=conf/application-dev.properties -Dlogback.configurationFile=logback.xml -classpath "target/*:target/lib/*")
build-server() { (cd "$SERVER_DIR" && mvn clean install -Dmaven.test.skip=true --batch-mode); }
start-repo() { (cd "$SERVER_DIR/RepoSvc" && java "${COMMON_OPTIONS[@]}" -Dderby.stream.error.file=RepositoryRoot/log/derby.log -Dfile.encoding=UTF-8 com.greenlight.camel.CamelMain); }
start-history() { (cd "$SERVER_DIR/ActivityHistory" && java "${COMMON_OPTIONS[@]}" com.greenlight.camel.CamelMain); }
start-auth() { (cd "$SERVER_DIR/AuthZ" && java "${COMMON_OPTIONS[@]}" com.greenlight.idm.CamelMain); }

start-server() { start-history & start-auth & start-repo & }
stop-server() { jobs -p | xargs -n1 pkill -SIGINT -g; }

#client folder actions
ggi() { (cd "$CLIENT_DIR" && npm i) }
ggdev() { (cd "$CLIENT_DIR" && nvim) }

# style guide
ggstyle() { (cd "$STYLE_DIR" && npx serve) }

# run in production mode
buildprod(){ (npm run build -- -e production -a false && NODE_EXTRA_CA_CERTS=~/gg/client/ssl/mkcert.rootCA.pem npm run serve development) }

# local AWS development stack
upstack(){ (cd "$CLIENT_DIR" && npm run startLocalstack && npm run buildServerlessComponents) }
destack(){ (cd "$CLIENT_DIR" && npm run destroyLocalstack) }
restack(){ (cd "$CLIENT_DIR" && npm run destroyLocalstack && npm run startLocalstack && npm run buildServerlessComponents) }

# local tomcat server
alias start-tomcat="/opt/gg/tomcat/bin/startup.sh"
alias stop-tomcat="/opt/gg/tomcat/bin/shutdown.sh"

# access psql server
db_postgres(){ (psql "dbname=postgres host=localhost user=ggadmin password=ggpass port=5432") }


