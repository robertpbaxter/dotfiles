#-----Config-----#

# Node
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load neovim using vim configs
export NVM_DIR=~/.nvm
source /usr/local/opt/nvm/nvm.sh

# List documents in a single row
alias ls="ls -l"
alias lsa="ls -al"

# Autocomplete git branches
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi



#-----Shortcuts-----#

# Git
alias gcd="git checkout develop"

# StyleGuide
alias styleguide="python -m SimpleHTTPServer 5000"