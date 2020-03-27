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
    source /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
    ;;
  *)       exit 1;;
esac


# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

