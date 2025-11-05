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

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    read -r -d '' cwd <"$tmp"
    if [[ $cwd != "$PWD" ]]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gabriel/.conda/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gabriel/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/gabriel/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/gabriel/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
