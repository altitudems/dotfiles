# Dotfiles

Bare repo dotfiles setup using `git --bare` and a `config` alias.

## Bootstrap
Run this on a new machine:

```bash
curl -fsSL https://raw.githubusercontent.com/altitudems/dotfiles/main/dotfiles-bootstrap.sh | bash
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
- Sensitive files (e.g., `~/.ssh`, `~/.netrc`) should remain untracked.
