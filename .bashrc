# ---------------------------------------------------------
# Author: Gabriel Maguire
# ---------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
alias diff='diff --color=auto'
alias grep='grep --color=auto'

export EZA_COLORS="uu=0:gu=0"
alias l="eza"
alias ll="eza -l"
alias la="eza -la"

alias gs="git status"

# dotfile management
alias config='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# ---------------------------------------------------------
# Environment config
# ---------------------------------------------------------
eval "$(fzf --bash)"
eval "$(starship init bash)"
