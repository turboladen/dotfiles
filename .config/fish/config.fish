### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/steve.loveless/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

if status is-login
  set -gx EDITOR /opt/homebrew/bin/nvim
  set -gx HOMEBREW_CASK_OPTS "--appdir=~/Applications"

  # https://github.com/sharkdp/bat?tab=readme-ov-file#man
  # set -gx MANPAGER="sh -c 'col -bx | bat -l man -p'"
  set -gx MANPAGER sh\ -c\ \'col\ -bx\ \|\ bat\ -l\ man\ -p\'

  # FZF integration with bat for file previews
  set -gx FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {}'"

end

if status is-interactive
  # ╭────────────────────────╮
  # │ Turn off fish greeting │
  # ╰────────────────────────╯
  set fish_greeting

  # ╭─────────╮
  # │ Aliases │
  # ╰─────────╯
  alias .. 'cd ..'

  fish_vi_key_bindings

  fastfetch
end

# pnpm
set -gx PNPM_HOME "/Users/steve.loveless/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Postgres.app
fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/bin
fish_add_path ~/Applications/Postgres.app/Contents/Versions/latest/lib
