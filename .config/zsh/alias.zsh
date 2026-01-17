chmod +x ~/.local/bin/fabric

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
