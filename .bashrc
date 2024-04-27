# ---------------------------------------------------------
# Author: Gabriel Maguire
# ---------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Start X if not running
if [ -z $DISPLAY ]; then
	startx

# Else, start tmux if X is running
elif command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi

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
alias la="eza -lA"

alias python='python3'

alias gs="git status"
alias gl="git log --oneline --graph"

# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# ---------------------------------------------------------
# Environment config
# ---------------------------------------------------------
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

. "$HOME/.cargo/env"

# Ctrl-o to open LF terminal file manager
lfcd() {
	# `command` is needed in case `lfcd` is aliased to `lf`
	cd "$(command lf -print-last-dir "$@")"
}
bind '"\C-o":"lfcd\C-m"'

eval "$(fzf --bash)"
eval "$(starship init bash)"
