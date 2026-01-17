# Dotfiles

Bare repo dotfiles setup using `git --bare` and a `config` alias.

## Install
Install shell tooling, fonts, and common tools:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles/install.sh | bash
```

Debian/Ubuntu: installs Nerd Fonts via `fonts-nerd-fonts` when available.

## Bootstrap
Run this on a new machine after install:

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

## Notes
- The repo is a bare git repository at `~/.dotfiles` with work tree `$HOME`.
- `status.showUntrackedFiles` is disabled to keep output clean.
- `dotfiles/bootstrap.sh` only backs up conflicting files on first run.
- Sensitive files (e.g., `~/.ssh`, `~/.netrc`) should remain untracked.
