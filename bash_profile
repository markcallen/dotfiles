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
