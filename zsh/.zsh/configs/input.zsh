# Borrowed from zim
# https://github.com/zimfw/zimfw/blob/master/modules/input/init.zsh

#
# Editor and input char assignment
#

[[ ${TERM} != 'dumb' ]] && () {

  # Use human-friendly identifiers.
  zmodload -F zsh/terminfo +b:echoti +p:terminfo
  typeset -gA key_info
  key_info=(
    'Control'      '\C-'
    'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
    'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
    'Escape'       '\e'
    'Meta'         '\M-'
    'Backspace'    "${terminfo[kbs]}"
    'BackTab'      "${terminfo[kcbt]}"
    'Left'         "${terminfo[kcub1]}"
    'Down'         "${terminfo[kcud1]}"
    'Right'        "${terminfo[kcuf1]}"
    'Up'           "${terminfo[kcuu1]}"
    'Delete'       "${terminfo[kdch1]}"
    'End'          "${terminfo[kend]}"
    'F1'           "${terminfo[kf1]}"
    'F2'           "${terminfo[kf2]}"
    'F3'           "${terminfo[kf3]}"
    'F4'           "${terminfo[kf4]}"
    'F5'           "${terminfo[kf5]}"
    'F6'           "${terminfo[kf6]}"
    'F7'           "${terminfo[kf7]}"
    'F8'           "${terminfo[kf8]}"
    'F9'           "${terminfo[kf9]}"
    'F10'          "${terminfo[kf10]}"
    'F11'          "${terminfo[kf11]}"
    'F12'          "${terminfo[kf12]}"
    'Home'         "${terminfo[khome]}"
    'Insert'       "${terminfo[kich1]}"
    'PageDown'     "${terminfo[knp]}"
    'PageUp'       "${terminfo[kpp]}"
  )

  # Bind the keys

  local key
  for key (${(s: :)key_info[ControlLeft]}) bindkey ${key} backward-word
  for key (${(s: :)key_info[ControlRight]}) bindkey ${key} forward-word

  if [[ -n ${key_info[Home]} ]] bindkey ${key_info[Home]} beginning-of-line
  if [[ -n ${key_info[End]} ]] bindkey ${key_info[End]} end-of-line

  if [[ -n ${key_info[PageUp]} ]] bindkey ${key_info[PageUp]} up-line-or-history
  if [[ -n ${key_info[PageDown]} ]] bindkey ${key_info[PageDown]} down-line-or-history

  if [[ -n ${key_info[Insert]} ]] bindkey ${key_info[Insert]} overwrite-mode

  if [[ -n ${key_info[Backspace]} ]] bindkey ${key_info[Backspace]} backward-delete-char
  if [[ -n ${key_info[Delete]} ]] bindkey ${key_info[Delete]} delete-char

  if [[ -n ${key_info[Left]} ]] bindkey ${key_info[Left]} backward-char
  if [[ -n ${key_info[Right]} ]] bindkey ${key_info[Right]} forward-char

  # Expandpace.
  bindkey ' ' magic-space

  # Clear
  bindkey "${key_info[Control]}L" clear-screen

  # Bind <Shift-Tab> to go to the previous menu item.
  if [[ -n ${key_info[BackTab]} ]] bindkey ${key_info[BackTab]} reverse-menu-complete

  # Use smart URL pasting and escaping.
  autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

  if zstyle -t ':zim:input' double-dot-expand; then
    double-dot-expand() {
      if [[ ${LBUFFER} == *.. ]]; then
        LBUFFER+='/..'
      else
        LBUFFER+='.'
      fi
    }
    zle -N double-dot-expand
    bindkey '.' double-dot-expand
    bindkey -M isearch '.' self-insert
  fi

  autoload -Uz is-at-least && if ! is-at-least 5.3; then
    # Redisplay after completing, and avoid blank prompt after <Tab><Tab><Ctrl-C>
    expand-or-complete-with-redisplay() {
      print -Pn '...'
      zle expand-or-complete
      zle redisplay
    }
    zle -N expand-or-complete-with-redisplay
    bindkey "${key_info[Control]}I" expand-or-complete-with-redisplay
  fi

  # Put into application mode and validate ${terminfo}
  zle-line-init() {
    if (( ${+terminfo[smkx]} )) echoti smkx
  }
  zle-line-finish() {
    if (( ${+terminfo[rmkx]} )) echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
}
