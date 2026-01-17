#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/altitudems/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

config() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

if [[ -f "$HOME/.zshrc" ]] && ! grep -q "alias config=\"/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME\"" "$HOME/.zshrc"; then
  printf '\n%s\n' 'alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> "$HOME/.zshrc"
fi

config config status.showUntrackedFiles no

if ! config checkout; then
  echo "Checkout failed. Backing up pre-existing files to ~/dotfiles-backup."
  mkdir -p "$HOME/dotfiles-backup"
  config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv "$HOME/{}" "$HOME/dotfiles-backup/" || true
  config checkout
fi

config checkout

if [[ -f "$HOME/.zshrc" ]]; then
  echo "Dotfiles checked out. Run: source ~/.zshrc"
fi
