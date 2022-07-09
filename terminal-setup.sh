#!/bin/bash

osName="$(uname -s)"
case "${osName}" in
  Linux*)  os=Linux;;
  Darwin*) os=Mac;;
  *)       exit 1;;
esac

echo "Setup terminal for $os"

# Go Home
pushd $HOME

# Create .ssh key
if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 .ssh
fi

if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 4096 -C $(whoami)@$(hostname) -f ~/.ssh/id_rsa -q -N ""
fi

# Install

echo "Installing necessary packages for development"
if [ $os == "Linux" ]; then
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt-get update
  sudo apt install -y tmux vim git powerline python3 python3-pip jq vim silversearcher-ag fzf
elif [ $os == "Darwin" ]; then
  if [ ! -x brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    xcode-select --install
  fi
  brew install python3 tmux jq vim yamllint fzf bash-completion jenv
  brew install --cask iterm2
fi

echo "Install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
npm install -g fixjson

echo "Install powerline"
pip3 install powerline-status
pip3 install --user powerline-gitstatus

if [ $os == "Linux" ]; then
   wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
   wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
   mv PowerlineSymbols.otf /usr/share/fonts/
   fc-cache -vf /usr/share/fonts/
   mv 10-powerline-symbols.conf /etc/fonts/conf.d/
elif [ $os == "Darwin" ]; then
  git clone https://github.com/powerline/fonts.git --depth=1
  pushd fonts && ./install.sh && popd
  rm -rf fonts
fi

# Get dotfiles
if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/markcallen/dotfiles ~/.dotfiles
else
  pushd .dotfiles && git pull && popd
fi

pushd .dotfiles && ./install && popd

# Go back to where we started from
popd

exit 0;
