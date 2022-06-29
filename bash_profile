export EDITOR=vim

# brew
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

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
[[ -r /usr/local/google-cloud-sdk/path.bash.inc ]] && source '/usr/local/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
[[ -r /usr/local/google-cloud-sdk/completion.bash.inc ]] && source '/usr/local/google-cloud-sdk/completion.bash.inc'

# rvm

# go lang
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# Python 3.8
export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"

# Powerline
[[ -x $HOMEBREW_PREFIX/bin/powerline-daemon ]] && $HOMEBREW_PREFIX/bin/powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
[[ -r $HOMEBREW_PREFIX/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh ]] && source $HOMEBREW_PREFIX/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh 

alias ssh-au='ssh -X fdata@dev-aucpycts-01.cs.athabascau.ca'
alias oscardb='mysql -u root -p --protocol=tcp'
alias ggraph='git log --oneline --graph'
alias tf=terraform
alias k=kubectl

genpasswd() { pwgen -Bs $1 1 |pbcopy |pbpaste; echo “Has been copied to clipboard”
}
source "$HOME/.cargo/env"

# issue with git in the wrong path
export PATH=$HOMEBREW_PREFIX/bin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/curl/bin:$PATH
export PATH=$HOMEBREW_PREFIX/opt/php@7.4/sbin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s $(brew --prefix asdf)/libexec/asdf.sh ]] && source $(brew --prefix asdf)/libexec/asdf.sh # load asdf

# Fix issue with terraform not working correctly on M1
export GODEBUG=asyncpreemptoff=1;

# source .bash_profile.local
if [ -f $HOME/.bash_profile.local ]; then
        source $HOME/.bash_profile.local
fi
