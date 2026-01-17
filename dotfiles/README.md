# Dotfiles

Bare repo dotfiles setup using `git --bare` and a `config` alias.

## New Machine
1) Install shell tooling, fonts, and common tools:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles/install.sh | bash
```

Debian/Ubuntu: installs Linuxbrew and uses `Brewfile.common` + `Brewfile.linux`, plus Nerd Fonts via `fonts-nerd-fonts`, VS Code via Microsoft repo, and Zed via the official install script.

2) Bootstrap dotfiles:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles/bootstrap.sh | bash
```

## Install
Run this anytime to update tools and fonts:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles/install.sh | bash
```

## Bootstrap
Run this anytime to sync dotfiles into `$HOME`:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles/bootstrap.sh | bash
```

## Usage
Manage dotfiles with the `config` alias:

```bash
config status
config add ~/.zshrc
config commit -m "Update zshrc"
config push
```

Manage Homebrew packages with the Brewfiles:

```bash
brew bundle --file ~/dotfiles/Brewfile.common
brew bundle --file ~/dotfiles/Brewfile.macos
brew bundle --file ~/dotfiles/Brewfile.linux
```

Infisical helper (project: dotfiles, env: dev):

```bash
irun env
```

## Notes
- The repo is a bare git repository at `~/.dotfiles` with work tree `$HOME`.
- `status.showUntrackedFiles` is disabled to keep output clean.
- `dotfiles/bootstrap.sh` only backs up conflicting files on first run.
- Sensitive files (e.g., `~/.ssh`, `~/.netrc`) should remain untracked.
