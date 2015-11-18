#
# Functions
#

# Add remote tracking branch in git
function git-new-remote-tracking {
  git checkout -b $1 && git push -u origin $1
}

# Remove local & remote branches in git
function git-nuke {
  git branch -D $1 && git push origin :$1
}
alias __git-checkout_main=_git_checkout

compdef _git git-nuke=git-checkout
