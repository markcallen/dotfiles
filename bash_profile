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

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
