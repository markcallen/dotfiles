#!/bin/bash

# OS
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
  sudo apt install -y tmux vim git powerline python3 python3-pip
elif [ $os == "Darwin" ]; then
  if [ ! -x brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    xcode-select --install
  fi
  brew install python3 tmux 
fi

pip3 install powerline-status
pip3 install --user powerline-gitstatus

git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts && ./install.sh && popd
rm -rf fonts

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
