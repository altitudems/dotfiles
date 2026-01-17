#!/usr/bin/env bash
set -euo pipefail

OS_NAME="$(uname -s)"

if [[ "$OS_NAME" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it from https://brew.sh and re-run."
    exit 1
  fi

  brew install git zsh fzf eza bat yt-dlp
  brew install --cask font-gohufont-nerd-font

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  fi

  if ! command -v pnpm >/dev/null 2>&1; then
    brew install pnpm
  fi

  if ! command -v bun >/dev/null 2>&1; then
    brew install bun
  fi

  if [[ -f "$HOME/dotfiles/Brewfile" ]]; then
    brew bundle --file "$HOME/dotfiles/Brewfile"
  fi
elif [[ "$OS_NAME" == "Linux" ]]; then
  if [[ -r /etc/os-release ]]; then
    . /etc/os-release
  fi

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y git zsh curl fzf bat eza yt-dlp fonts-nerd-fonts

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    fi

    if ! command -v pnpm >/dev/null 2>&1; then
      curl -fsSL https://get.pnpm.io/install.sh | sh -
    fi

    if ! command -v bun >/dev/null 2>&1; then
      curl -fsSL https://bun.sh/install | bash
    fi

    if [[ -f "$HOME/dotfiles/Brewfile" ]] && command -v brew >/dev/null 2>&1; then
      brew bundle --file "$HOME/dotfiles/Brewfile"
    fi

    echo "Nerd Fonts installed via fonts-nerd-fonts (if available)."
  else
    if [[ -n "${ID:-}" ]]; then
      echo "Unsupported Linux distro: $ID. Please install dependencies manually."
    else
      echo "Unsupported Linux package manager. Please install dependencies manually."
    fi
    exit 1
  fi
else
  echo "Unsupported OS: $OS_NAME"
  exit 1
fi

echo "Install complete. Run: source ~/.zshrc"
