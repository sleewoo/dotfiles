#!/usr/bin/env bash

_opts() {
  psql -X -t -d postgres -c "
    select datname
    from pg_database
    where datistemplate = false
    and datname <> 'postgres'
  "
}

_jsql() {

  local cur prev opts

  COMPREPLY=()

  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts="$(_opts)"

  COMPREPLY=(`compgen -W "$opts" -- $cur`)
  return 0

}

complete -F _jsql jsql

