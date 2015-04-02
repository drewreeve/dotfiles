setopt prompt_subst
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' formats '%F{green}%b%f:%.8i%f%c%u'
zstyle ':vcs_info:git*' formats '%F{green}%b%f%c%u'
zstyle ':vcs_info:*' actionformats '%F{green}%b%f|%F{red}%a%f:%.8i%f%c%u'
zstyle ':vcs_info:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}!%f'
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

PROMPT=$'\n''%F{blue}%~%f $vcs_info_msg_0_'$'\n''%(?.%F{green}.%F{red})$%f '

function +vi-git-untracked() {
  if [[ -n $(git ls-files --exclude-standard --others 2>/dev/null) ]]; then
    hook_com[unstaged]+="%F{red}?%f"
  fi
}
