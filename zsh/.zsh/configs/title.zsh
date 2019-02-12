#
# Sets terminal window and tab titles.
#

# Return if requirements are not found.
if [[ "$TERM" == (dumb|linux|*bsd*|eterm*) ]]; then
  return 1
fi

function set-window-title {
  print -Pn "\e]2;$1:q\a"
}

function set-tab-title {
  print -Pn "\e]1;$1:q\a"
}

function set-multiplexer-title {
  print -Pn "\ek$1:q\e\\"
}

function _title_precmd {
  local truncated_path="%15<...<%~%<<"

  if [[ "$TERM" == screen* ]]; then
    set-multiplexer-title "$truncated_path" # 15 char truncated PWD
  fi
  set-tab-title "$truncated_path"           # 15 char truncated PWD
  set-window-title "%n@%m: %~"              # window title = username@host: PWD
}

function _title_preexec {
  setopt extended_glob localoptions

  # Set the command name, or in the case of sudo or ssh, the next command.
  local cmd="${${2[(wr)^(*=*|sudo|ssh|-*)]}:t}"
  local truncated_cmd="${cmd/(#m)?(#c15,)/${MATCH[1,12]}...}"
  unset MATCH

  if [[ "$TERM" == screen* ]]; then
    set-multiplexer-title "$truncated_cmd"
  fi
  set-tab-title "$truncated_cmd"
  set-window-title "$cmd"
}

precmd_functions+=(_title_precmd)
preexec_functions+=(_title_preexec)
