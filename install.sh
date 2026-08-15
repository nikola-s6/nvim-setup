#!/usr/bin/env bash
# Bootstrap this Neovim config on a new machine.
#
#   git clone https://github.com/nikola-s6/nvim-setup ~/.config/nvim
#   ~/.config/nvim/install.sh
#
# Idempotent: safe to re-run at any time.

set -euo pipefail

CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m==>\033[0m %s\n' "$1"; }

# --- Omarchy live theme switching -------------------------------------------
# omarchy-theme-set rewrites ~/.local/state/omarchy/current/theme/neovim.lua on
# every theme change. Symlinking it into lua/plugins/ makes lazy.nvim's reloader
# notice the change (~2s) and lua/omarchy/theme.lua re-applies the colorscheme.
#
# The relative spelling below is the one Omarchy's own migrations look for, so
# their repair scripts keep recognising this link.
link_omarchy_theme() {
  local link="$CONFIG_DIR/lua/plugins/theme.lua"
  local target="../../../../.local/state/omarchy/current/theme/neovim.lua"
  local resolved="$HOME/.local/state/omarchy/current/theme/neovim.lua"

  if [[ ! -e $resolved ]]; then
    warn "No Omarchy theme found, skipping theme symlink (config falls back to tokyonight)"
    return
  fi

  if [[ -e $link && ! -L $link ]]; then
    warn "$link exists and is not a symlink, leaving it alone"
    return
  fi

  ln -sfn "$target" "$link"
  info "Linked lua/plugins/theme.lua -> $target"
}

# --- lazygit ----------------------------------------------------------------
install_lazygit_config() {
  local src="$CONFIG_DIR/additional-config/lazygit/config.yml"
  local dest="$HOME/.config/lazygit/config.yml"

  [[ -f $src ]] || return 0

  mkdir -p "$(dirname "$dest")"

  if [[ -f $dest ]] && ! cmp -s "$src" "$dest"; then
    if [[ -s $dest ]]; then
      cp "$dest" "$dest.bak.$(date +%s)"
      info "Backed up existing lazygit config"
    fi
  fi

  cp "$src" "$dest"
  info "Installed lazygit config to $dest"
}

link_omarchy_theme
install_lazygit_config

cat <<'EOF'

Done. Next:
  nvim            # lazy.nvim bootstraps itself and installs plugins
  :Lazy restore   # optional: pin every plugin to lazy-lock.json
  :checkhealth

External tools worth having: ripgrep, fd, make, lazygit, delta, prettierd, node, go.
EOF
