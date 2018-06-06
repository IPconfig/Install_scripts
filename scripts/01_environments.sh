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
# see https://blog.jez.io/2016/08/03/vim-and-haskell-in-2016-on-os-x/
brew install haskell-stack
stack  --resolver=lts-10.3 setup # https://www.stackage.org/snapshots
stack build intero
stack install hlint
}