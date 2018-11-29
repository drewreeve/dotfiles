#
# Prompt
#

setopt prompt_subst
autoload -Uz colors && colors
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
zstyle ':vcs_info:git*' formats '%F{green}%b%f %c%u'
zstyle ':vcs_info:*' actionformats '%F{green}%b%f|%F{red}%a%f:%.8i%f %c%u'
zstyle ':vcs_info:*' stagedstr '%B%F{yellow}+%f%b'
zstyle ':vcs_info:*' unstagedstr '%B%F{red}!%f%b'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

# prompt:
# %B => bold
# %b => unbold
# %F => color dict
# %f => reset color
# %m => shortname host
# %n => username
# %~ => current path
# %(?..) => prompt conditional - %(condition.true.false)

# Build prompt
PROMPT=$'\n''%F{blue}%~%f ${vcs_info_msg_0_}%f'  # current path and git info

# show username@host if logged in via ssh
[[ "$SSH_CONNECTION" != '' ]] && PROMPT+=" %F{242}%n@%m%f"

PROMPT+=$'\n'"%(?.%f.%F{red})%#%f " # red prompt if non zero exit code

# Append ? to vcs info if there are untracked files
function +vi-git-untracked() {
  if [[ -n $(git ls-files --exclude-standard --others 2>/dev/null) ]]; then
    hook_com[unstaged]+="%B%F{red}?%f%b"
  fi
}
