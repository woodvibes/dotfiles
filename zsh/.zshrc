echo "Loading ~/.zshrc"

### PROMPT STYLING ###

# VCS plugin
# ref: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# ref: https://sureshjoshi.com/development/zsh-prompts-that-dont-suck

# load vcs_info function
# this function loads relevant version control data into `${vcs_info_msg_*_}`
autoload -Uz vcs_info

# Set prompt substitution so we can use the vcs_info_message variable
setopt prompt_subst

# style vcs info
zstyle ':vcs_info:git:*' formats '%F{yellow}[%b]%f'

# default prompt
export DEFAULT_PROMPT=$'%(?.%F{blue}⏺.%F{red}⏺)%f %F{green}%1~%f'

# call before each prompt display using precmd hook
precmd_vcs_info() { 
	vcs_info
	if [[ -n "$vcs_info_msg_0_" ]]; then
		export PROMPT=$'\$DEFAULT_PROMPT \$vcs_info_msg_0_ > '
	else
		export PROMPT=$'\$DEFAULT_PROMPT > '
	fi
}
precmd_functions+=( precmd_vcs_info )

export CLICOLOR=1
export LSCOLORS=cxfxcxdxbxegedabagacad

### PATH UPDATES ###

echo "	Adding custom bins to \$PATH..."
export PATH=$PATH:$HOME/bin

### ALIASES ###

echo "	Setting up aliases..."

# git shorthands
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gs="git status"

# wtfs (what the file system) is my shorthand for trying to
# figure out wtf is eating up all my storage
alias wtfs="du -h -d 1 . 2> /dev/null | sort -h"

### FUNCTIONS ###

function nvm_init() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function clear_cache() {
  echo "clearing pip cache..."
  pip3 cache purge
  echo "clearing npm cache..."
  npm cache clean --force     
  echo "clearing go cache..."       
  go clean -modcache
}

### LOCAL OVERRIDES ###

# machine-specific config that shouldn't be committed lives in
# .zshrc.local next to this file (git-ignored)
ZSHRC_LOCAL="${${(%):-%x}:A:h}/.zshrc.local"
if [[ -f "$ZSHRC_LOCAL" ]]; then
  echo "	Loading local overrides..."
  source "$ZSHRC_LOCAL"
fi
unset ZSHRC_LOCAL

# Uncomment here and in ~/.zshenv to profile shell loading
# zprof

### CLEAN UP ###

echo "Done loading ~/.zshrc"

# no need to see the debug logs everytime :)
clear
