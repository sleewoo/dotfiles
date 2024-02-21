
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$(command -v exa)" ]; then
  alias ls="exa --all --group-directories-first --icons"
  alias ll="exa --all --group-directories-first --icons --long --group --git"
fi

if [ "$(command -v bat)" ]; then
  alias cat="bat --style=plain --pager=never"
fi

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"
eval "$(rbenv init - bash)"

function jsql() {
  psql -tX -d $1 -c "select row_to_json(row) from ($2) row"
}

function set_tmux_pane_title() {
  unset PROMPT_COMMAND
  printf "\033]2;%s\033\\" "$1"
}

alias kdiff="kitty +kitten diff"
alias icat="kitty +kitten icat"
alias jsql="jsql"

for f in ~/.config/bash_completion.d/*.sh; do
  source $f
done

