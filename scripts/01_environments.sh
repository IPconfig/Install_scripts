install_brew() {
  renew_sudo
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  # Disable analytics
  brew analytics off
}

install_fish(){
  brew install fish
  sudo --stdin sh -c 'echo "/usr/local/bin/fish" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo --stdin chsh -s '/usr/local/bin/fish' "${USER}" <<< "${sudo_password}" 2> /dev/null
}

install_python() {
  brew install python # install python 3
  pip install --upgrade pip setuptools wheel
  pip install pipenv # harnesses Pipfile, pip, and virtualenv into one single command.
}

install_ruby() {
  brew install ruby
  gem update --system
  gem install --no-document pygments.rb # needed for installing ghi with brew
}

install_haskell() {
brew install haskell-stack
stack --resolver=lts-11.12 setup # https://www.stackage.org/snapshots
stack build intero
stack install hlint
}