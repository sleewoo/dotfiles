#!/usr/bin/env bash

ktx_config="${KTX_CONFIG:-$HOME/.config/ktx}"

_opts() {
  if [[ $1 =~ / ]]; then
    local d f
    d=${1%/*}
    f=${1#*/}
    find "$ktx_config/$d" -type f -name "$f*.sh" -exec sh -c '
      echo $0/$(basename {} .sh)
    ' $d \;
  else
    find "$ktx_config" -mindepth 1 -maxdepth 1 -type d -name "$1*" -exec sh -c '
      d=$(basename {})
      echo $d
      for f in {}/*.sh; do
        echo "$d/$(basename $f .sh)"
      done
    ' \;
  fi
}

_ktx() {

  local curr prev opts

  COMPREPLY=()

  curr="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="$(_opts $curr)"

  COMPREPLY=(`compgen -W "$opts" -- $curr`)
  return 0

}

complete -F _ktx ktx

