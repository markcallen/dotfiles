export EDITOR=vim

if [ -n "${GOROOT:-}" ] && [ ! -d "$GOROOT" ]; then
  unset GOROOT
fi

osName="$(uname -s)"
case "${osName}" in
  Linux*)  
    source ~/.bash_profile.linux
    ;;
  Darwin*) 
    source ~/.bash_profile.osx
    ;;
  *) 
    echo "${osName} unknown OS"
    exit 1
    ;;
esac

if [ -d "$HOME/.aftman" ]; then
  . "$HOME/.aftman/env"
fi

# Cargo
if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

# tfenv
export PATH=~/.tfenv/bin:$PATH

# load asdf
if command -v brew >/dev/null 2>&1; then
  ASDF_PREFIX="$(brew --prefix asdf 2>/dev/null)"
  if [ -n "${ASDF_PREFIX:-}" ] && [ -s "${ASDF_PREFIX}/libexec/asdf.sh" ]; then
    . "${ASDF_PREFIX}/libexec/asdf.sh"
  fi
  unset ASDF_PREFIX
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="$PATH:/Users/mark/.local/bin"
export PATH="$HOME/develop/flutter/bin:$PATH"
