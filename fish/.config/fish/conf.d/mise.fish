if type -q mise
  # Add mise shims for non-interactive use
  mise activate fish --shims | source

  # Activate mise for interactive use
  if status is-interactive
    mise activate fish | source
  end
end
