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
  sudo add-apt-repository -y ppa:jonathonf/vim
  sudo apt-get update
  sudo apt-get install -y build-essential
  sudo apt install -y tmux vim git bash-completion powerline python3 python3-pip jq vim silversearcher-ag fzf
  if [ ! -x brew ]; then
    curl https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | NONINTERACTIVE=1 bash
  fi
  sudo apt install -y dnsutils iputils-ping
elif [ $os == "Darwin" ]; then
  if [ ! -x brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    xcode-select --install
  fi
  brew install python3 tmux jq vim yamllint fzf bash-completion jenv
  brew install --cask iterm2
  brew tap homebrew/cask-fonts
  brew install --cask font-fira-code
fi

echo "Install nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 16
nvm alias default 16

echo "Install powerline"
pip3 install powerline-status
pip3 install --user powerline-gitstatus

if [ $os == "Linux" ]; then
   wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
   wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
   sudo mv PowerlineSymbols.otf /usr/share/fonts/
   fc-cache -vf /usr/share/fonts/
   sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
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

pushd .dotfiles && ./install --plugin-dir dotbot-ifplatform && popd

# Go back to where we started from
popd

# terraform
#

brew install tfenv
tfenv install 1.1.7

# k8s

if [ $os == "Linux" ]; then
  brew install derailed/k9s/k9s
elif [ $os == "Darwin" ]; then
  brew install k9s
fi

brew install asdf
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl 1.23.6
asdf global kubectl 1.23.6

asdf plugin-add stern
asdf install stern 1.24.0
asdf global stern 1.24.0

brew install helm
brew install kustomize

exit 0;
