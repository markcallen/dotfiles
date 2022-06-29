# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

osName="$(uname -s)"
case "${osName}" in
  Linux*)  
    os=Linux
    source /usr/share/powerline/bindings/bash/powerline.sh
    ;;
  Darwin*) 
    os=Mac
    source /usr/local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
    ;;
  *)       exit 1;;
esac

[ -h '/usr/local/bin/vim' ] && alias vim='/usr/local/bin/vim'

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

export GIT_EDITOR=vim
if [ -f "/usr/local/go/bin/go" ]; then
    export PATH=$PATH:/usr/local/go/bin
    if [ ! -d ~/go ]; then
        mkdir ~/go
    fi
    export GOPATH=~/go
fi

# Cargo
if [ -d "$HOME/.cargo" ]; then
    source "$HOME/.cargo/env"
fi

alias tf=terraform

