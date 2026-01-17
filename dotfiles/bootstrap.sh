#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/altitudems/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

did_clone=false
if [[ ! -d "$DOTFILES_DIR" ]]; then
  git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR"
  did_clone=true
fi

config() {
  /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

if [[ -f "$HOME/.zshrc" ]] && ! grep -q "alias config=\"/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME\"" "$HOME/.zshrc"; then
  printf '\n%s\n' 'alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> "$HOME/.zshrc"
fi

config config status.showUntrackedFiles no

if ! config checkout; then
  if [[ "$did_clone" == true ]]; then
    echo "Checkout failed. Backing up pre-existing files to ~/dotfiles-backup."
    mkdir -p "$HOME/dotfiles-backup"
    config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv "$HOME/{}" "$HOME/dotfiles-backup/" || true
    config checkout
  else
    echo "Checkout failed due to local changes. Resolve conflicts and re-run."
    exit 1
  fi
fi

if [[ -f "$HOME/.zshrc" ]]; then
  echo "Dotfiles checked out. Run: source ~/.zshrc"
fi
