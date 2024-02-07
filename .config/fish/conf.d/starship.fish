if status --is-interactive
  # starship init fish | source
  source ("/opt/homebrew/bin/starship" init fish --print-full-init | psub)
end

