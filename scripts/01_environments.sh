install_brew() {
  renew_sudo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
}

install_python() {
  brew install python3
  # install some eggs
  pip3 install livestreamer subliminal
}