#
# Prompt
#

setopt prompt_subst
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd vcs_info

# vcs_info:
# %a => current action (rebase/merge etc)
# %b => current branch
# %c => string from `stagedstr` if there are staged changes
# %i => current revision number/identifier
# %u => string from `unstagedstr` if there are unstaged changes

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' formats '%F{green}%b%f:%.8i%f %c%u'
zstyle ':vcs_info:git*' formats '%F{magenta}%b%f %c%u'
zstyle ':vcs_info:*' actionformats '%F{green}%b%f|%F{red}%a%f:%.8i%f %c%u'
zstyle ':vcs_info:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

# Append ? to vcs info if there are untracked files
function +vi-git-untracked() {
  if [[ -n $(git ls-files --exclude-standard --others 2>/dev/null) ]]; then
    hook_com[unstaged]+="%F{red}?%f"
  fi
}

# prompt:
# %B => bold
# %b => unbold
# %F => color dict
# %f => reset color
# %m => shortname host
# %n => username
# %~ => current path
# %(?..) => prompt conditional - %(condition.true.false)

prompt_simples_setup() {
  prompt=$'\n''%B'

  # If this is an ssh connection show user@hostname
  if [[ -n $SSH_CONNECTION ]]; then
    prompt+='%F{yellow}%n%f@%F{green}%m%f: '
  fi

  prompt+='%F{cyan}%~%f '
  prompt+='${vcs_info_msg_0_}'          # git info
  prompt+=$'\n'"%(?.%f.%F{red})%#%f%b " # red prompt if non zero exit code
}

prompt_simples_setup "$@"
