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

# Created by `pipx` on 2024-09-23 19:34:34
export PATH="$PATH:/Users/mark/.local/bin"

