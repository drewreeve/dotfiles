if type -q mise
  # Activate mise for interactive use
  if status is-interactive
    mise activate fish | source
  # Add the shims for non-interactive use
  else
    mise activate fish --shims | source
  end
end
