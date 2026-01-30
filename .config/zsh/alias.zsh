[[ -f ~/.local/bin/fabric ]] && chmod +x ~/.local/bin/fabric

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
if [[ -n "$CURSOR_AGENT" ]]; then
  # Skip aliases for better compatibility
else
  alias cat=bat
fi
alias python=python3
alias y=yt-dlp -f "bestvideo[height<=720]+bestaudio/best"
alias ls="eza -lah --icons"
alias l="eza -ah --icons"

infisical_run() {
  infisical run --projectId "9b6ef6ff-144d-4211-9de6-085fba02170c" --env "dev" -- "$@"
}

alias irun=infisical_run
