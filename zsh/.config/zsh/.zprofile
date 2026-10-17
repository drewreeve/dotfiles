# Add mise shims for non-interactive use; .zshrc activates mise for interactive use.
# mise may not be on $PATH yet, so add the shims directory directly.
path=(${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}/shims(N) $path)
