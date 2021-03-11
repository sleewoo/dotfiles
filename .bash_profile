
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -GFh --color=auto --group-directories-first'

#eval "$(starship init bash)"

export HISTCONTROL=ignoreboth:erasedups

export ERL_AFLAGS="-kernel shell_history enabled"

export PGTZ=UTC

source ~/.config/tmuxinator.sh

export PATH="~/.npm-global/bin:~/.gem/ruby/2.7.0/bin:$PATH"

export RIPGREP_CONFIG_PATH="~/.config/rg.conf"
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='-m --height 50% --border'

