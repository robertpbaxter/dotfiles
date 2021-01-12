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

# nvm
export NVM_DIR=~/.nvm
source /usr/local/opt/nvm/nvm.sh
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# gg aliases
REPO_DIR="$HOME/gg"
GG_DIR="$REPO_DIR/GG"
CLIENT_DIR="$REPO_DIR/client"
SERVER_DIR="$REPO_DIR/server"
MICRO_DIR="$REPO_DIR/microservices"
STYLE_DIR="$REPO_DIR/style"
ggg() { cd "$REPO_DIR/gg" }
ggc() { cd "$REPO_DIR/client" }
ggs() { cd "$REPO_DIR/server" }
ggm() { cd "$REPO_DIR/microservices" }
ggup() { (cd "$GG_DIR/local/vm" && ./gg.sh start) }
ggdown() { (cd "$GG_DIR/local/vm" && ./gg.sh stop) }

start-docker() { (cd "$GG_DIR/local/docker"; ./gg.sh Start); }
stop-docker() { (cd "$GG_DIR/local/docker"; ./gg.sh Stop); }
docker-status() { (cd "$GG_DIR/local/docker"; ./gg.sh Status); }

ggrmemails ()
{
    du -sh /var/tmp/emails
    ls -1 /var/tmp/emails | wc -l
    find /var/tmp/emails -type f \( -iname '*.json' -o -iname '*.html' \) -exec rm '{}' +
  }

# intelliJ
COMMON_OPTIONS=(-Dgreenlight.application.properties=conf/application-dev.properties -Dlogback.configurationFile=logback.xml -classpath "target/*:target/lib/*")
build-server() { (cd "$SERVER_DIR" && mvn clean install -Dmaven.test.skip=true --batch-mode); }
build-impact() { (cd "$MICRO_DIR/impact-service" && mvn clean install -D maven.test.skip=true --batch-mode); }
start-repo() { (cd "$SERVER_DIR/RepoSvc" && java "${COMMON_OPTIONS[@]}" -Dderby.stream.error.file=RepositoryRoot/log/derby.log -Dfile.encoding=UTF-8 com.greenlight.camel.CamelMain); }
start-history() { (cd "$SERVER_DIR/ActivityHistory" && java "${COMMON_OPTIONS[@]}" com.greenlight.camel.CamelMain); }
start-auth() { (cd "$SERVER_DIR/AuthZ" && java "${COMMON_OPTIONS[@]}" com.greenlight.idm.CamelMain); }
start-impact() { (cd $MICRO_DIR/impact-service && java -jar target/greenlight-impact-service.jar); }
start-analytics() { (cd "$SERVER_DIR/Analytics/target" && java -jar greenlight-analytics-service.jar); }

start-server() { start-history & start-auth & start-repo & start-impact & }
stop-server() { jobs -p | xargs -n1 pkill -SIGINT -g; }

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
db_analytics(){ (psql "dbname=analytics host=localhost user=ggadmin password=ggpass port=5432") }

# cert location for builds pre-2019.4.0
# export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
