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

# Add github.com key
ssh-keyscan github.com ~/.ssh/known_hosts

# Install

echo "Installing necessary packages for development"
if [ $os == "Linux" ]; then
  # see https://askubuntu.com/questions/1367139/apt-get-upgrade-auto-restart-services
  if [ -f /etc/needrestart/needrestart.conf ]; then
    sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
  fi
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
  brew install python3 tmux jq vim yamllint fzf bash-completion@2 jenv
  brew install --cask iterm2
  brew tap homebrew/cask-fonts
  brew install --cask font-fira-code
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

echo "Install nvm"
brew install nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install 16
nvm alias default 16

echo "Install go"
brew install go

echo "Install pyenv"
brew install openssl readline sqlite3 xz zlib
brew install pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
#pyenv install 3.9.4
#pyenv global 3.8

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
#
pip3 install distro
if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/markcallen/dotfiles ~/.dotfiles
else
  pushd .dotfiles && git pull && popd
fi

pushd .dotfiles && ./install --plugin-dir dotbot-ifplatform && popd

# Go back to where we started from
popd

# terraform
echo "Install tfenv"
brew install tfenv
tfenv install 1.1.7

# k8s
echo "Install k9s"
if [ $os == "Linux" ]; then
  brew install derailed/k9s/k9s
elif [ $os == "Darwin" ]; then
  brew install k9s
fi

echo "Install asdf for kubectl and stern"
brew install asdf
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl 1.23.6
asdf global kubectl 1.23.6

asdf plugin-add stern
asdf install stern 1.24.0
asdf global stern 1.24.0

asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install helm 3.14.4
asdf global helm 3.14.4

asdf plugin-add nova
asdf install nova latest
asdf local nova latest

asdf plugin-add pluto
asdf list-all pluto
asdf install pluto 5.19.0
asdf local pluto 5.19.0

for PACKAGE in kustomize kubectx
do
  brew install $PACKAGE
done

exit 0;
