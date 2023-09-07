#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\[\e[32;1m\]\u@\h\[\e[0m\] \W]\$ '

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

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
