export EDITOR=vim

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
[[ -s $(brew --prefix asdf)/libexec/asdf.sh ]] && source $(brew --prefix asdf)/libexec/asdf.sh 

export PATH="$PATH:/Users/mark/.local/bin"
export PATH="$HOME/develop/flutter/bin:$PATH"
