
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$(command -v exa)" ]; then
  alias ls="exa --all --group-directories-first --icons"
  alias ll="exa --all --group-directories-first --icons --long --group --git"
fi

if [ "$(command -v bat)" ]; then
  alias cat="bat --style=plain --pager=never"
fi

alias cclip="xclip -selection clipboard"

export PATH="~/.npm-global/bin:~/.gem/ruby/2.7.0/bin:$PATH"

export HISTCONTROL="ignoreboth:erasedups"

export ERL_AFLAGS="-kernel shell_history enabled"
export PGTZ="UTC"

export FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-file=$HOME/.gitignore.global"
export FZF_DEFAULT_OPTS=" \
  --multi --history $HOME/.cache/.fzf-history \
  --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1 \
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1 \
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac \
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b \
"

source ~/.config/tmuxinator.sh
eval "$(zoxide init bash)"

