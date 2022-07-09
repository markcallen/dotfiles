export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rust
if [ -d $HOME/.cargo ]; then
  source "$HOME/.cargo/env"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d $HOME/.rvm ]; then
  export PATH="$PATH:$HOME/.rvm/bin"
fi

if [ -d $HOME/.yarn ]; then
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# jenv
if [ -d $HOME/.jenv ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# go lang
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# aliases
alias ggraph='git log --oneline --graph'
alias tf=terraform
alias k=kubectl
