
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls="ls -GFh --color=auto --group-directories-first"

export PATH="~/.npm-global/bin:~/.gem/ruby/2.7.0/bin:$PATH"

export HISTCONTROL="ignoreboth:erasedups"

export ERL_AFLAGS="-kernel shell_history enabled"
export PGTZ="UTC"

export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_DEFAULT_OPTS="--multi --border --height 50% --history $HOME/.cache/.fzf-history"

source ~/.config/tmuxinator.sh

