#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f ~/.bash/git-prompt.sh ]; then
    source ~/.bash/git-prompt.sh
    git_branch='$(__git_ps1 " [\e[0;35m%s\e[m]")'
fi

PS1="[\e[0;32m\]\u@\h\[\e[0m] [\e[0;34m\w\e[m]${git_branch-}\n> "

###########################################################
# History
###########################################################
HISTSIZE=10000
HISTTIMEFORMAT="[%F %T]$ "
HISTCONTROL=ignoreboth

###########################################################
# Aliases
###########################################################
alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias l="ls -lAFh"

alias python='python3'

# git
alias gs="git status"
alias gl="git log --oneline --graph --all"

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
