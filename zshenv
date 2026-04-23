if [[ -n "${GOROOT:-}" && ! -d "$GOROOT" ]]; then
  unset GOROOT
fi

if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

if [[ -f "$HOME/.aftman/env" ]]; then
  . "$HOME/.aftman/env"
fi
