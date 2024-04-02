# ---------------------------------------------------------
# Author: Gabriel Maguire
# ---------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# ---------------------------------------------------------
# Prompt String
# ---------------------------------------------------------
if [ -f ~/.bash/git-prompt.sh ]; then
    source ~/.bash/git-prompt.sh
    git_branch='$(__git_ps1 " [\e[0;35m%s\e[m]")'
fi

PS1="[\e[0;32m\]\u@\h\[\e[0m] [\e[0;34m\w\e[m]${git_branch-}\n> "

# ---------------------------------------------------------
# History
# ---------------------------------------------------------
HISTSIZE=10000
HISTTIMEFORMAT="[%F %T]$ "
HISTCONTROL=ignoreboth

# ---------------------------------------------------------
# Aliases
# ---------------------------------------------------------
alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EZA_COLORS="uu=0:gu=0"
alias l="eza"
alias ll="eza -l"
alias la="eza -lA"

alias python='python3'

alias gs="git status"
alias gl="git log --oneline --graph"

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

. "$HOME/.cargo/env"
