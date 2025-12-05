echo "Loading ~/.zshrc"

echo "	Setting prompt styles..."
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{magenta}[%b]%f'
export PROMPT=$'%(?..Exited with Code %?\n)\n%F{blue}%1~%f \$vcs_info_msg_0_ % '

echo "	Adding custom bins to \$PATH..."
export PATH=$PATH:$HOME/bin

# export CLICOLOR=1
# export LSCOLORS=cxfxcxdxbxegedabagacad

echo "	Setting up aliases..."

function nvm_init() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gs="git status"

alias wtfs="du -h -d 1 . 2> /dev/null | sort -h"

function clear_cache() {
  echo "clearing pip cache..."
  pip3 cache purge
  echo "clearing npm cache..."
  npm cache clean --force     
  echo "clearing go cache..."       
  go clean -modcache
}

# Uncomment here and in ~/.zshenv to profile shell loading
# zprof

echo "Done loading ~/.zshrc"

# no need to see the debug logs everytime :)
clear
