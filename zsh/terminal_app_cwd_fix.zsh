# Updates current working directory for osx Terminal.app
function terminal_cwd_fix {
  local PWD_URL="file://$HOSTNAME${PWD// /%20}"
  printf '\e]7;%s\a' "$PWD_URL"
}

add-zsh-hook precmd terminal_cwd_fix
