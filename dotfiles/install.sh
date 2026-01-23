#!/usr/bin/env bash
set -euo pipefail

OS_NAME="$(uname -s)"

if [[ "$OS_NAME" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it from https://brew.sh and re-run."
    exit 1
  fi

  if [[ -f "$HOME/dotfiles/Brewfile.common" ]]; then
    brew bundle --file "$HOME/dotfiles/Brewfile.common"
  else
    echo "Brewfile not found at ~/dotfiles/Brewfile.common."
    exit 1
  fi

  if [[ -f "$HOME/dotfiles/Brewfile.macos" ]]; then
    brew bundle --file "$HOME/dotfiles/Brewfile.macos"
  fi

  if command -v asdf >/dev/null 2>&1; then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git || true
    asdf plugin add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git || true
    asdf install
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  fi

elif [[ "$OS_NAME" == "Linux" ]]; then
  if [[ -r /etc/os-release ]]; then
    . /etc/os-release
  fi

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y build-essential curl file git gpg unzip fontconfig

    mkdir -p "$HOME/.fonts"
    curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Gohu.zip -o /tmp/Gohu.zip
    unzip -o /tmp/Gohu.zip -d "$HOME/.fonts"
    fc-cache -f

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
      RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    fi

    if [[ ! -d "$HOME/.asdf" ]]; then
      git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.0
    fi

    if ! command -v brew >/dev/null 2>&1; then
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
        eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
      fi
    fi

    if command -v brew >/dev/null 2>&1; then
      if [[ -f "$HOME/dotfiles/Brewfile.common" ]]; then
        brew bundle --file "$HOME/dotfiles/Brewfile.common"
      fi

      if [[ -f "$HOME/dotfiles/Brewfile.linux" ]]; then
        brew bundle --file "$HOME/dotfiles/Brewfile.linux"
      fi
    else
      echo "Homebrew failed to install. Install it manually and re-run."
      exit 1
    fi

    if ! command -v infisical >/dev/null 2>&1; then
      curl -1sLf 'https://artifacts-cli.infisical.com/setup.deb.sh' | sudo -E bash
      sudo apt-get update
      sudo apt-get install -y infisical
    fi

    if ! command -v code >/dev/null 2>&1; then
      curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg >/dev/null
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
      sudo apt-get update
      sudo apt-get install -y code
    fi

    if ! command -v zed >/dev/null 2>&1; then
      curl -f https://zed.dev/install.sh | sh
    fi

    if [[ -s "$HOME/.asdf/asdf.sh" ]]; then
      . "$HOME/.asdf/asdf.sh"
    fi

    if command -v asdf >/dev/null 2>&1; then
      asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git || true
      asdf plugin add golang https://github.com/asdf-community/asdf-golang.git || true
      asdf plugin add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git || true
      asdf install
    fi

    echo "Gohu Nerd Font installed."
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
