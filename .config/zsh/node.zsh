# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# asdf
export ASDF_DIR="$HOME/.asdf"
[ -s "/opt/homebrew/opt/asdf/libexec/asdf.sh" ] && source "/opt/homebrew/opt/asdf/libexec/asdf.sh"
[ -s "/usr/local/opt/asdf/libexec/asdf.sh" ] && source "/usr/local/opt/asdf/libexec/asdf.sh"
[ -s "$ASDF_DIR/asdf.sh" ] && source "$ASDF_DIR/asdf.sh"
