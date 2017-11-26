install_brew() {
  renew_sudo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  # Disable analytics
  brew analytics off
}

install_fish(){
  brew install fish --HEAD
  sudo --stdin sh -c 'echo "/usr/local/bin/fish" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo --stdin chsh -s '/usr/local/bin/fish' "${USER}" <<< "${sudo_password}" 2> /dev/null
  sudo --stdin sh -c 'echo "eval (python3 -m virtualfish compat_aliases auto_activation projects)" >> ~/.config/fish/config.fish'
}

install_python() {
  brew install python # this will already prefer the brewed one above the system installed one
  pip install --upgrade pip

  # python3
  brew install python3
  pip3 install --upgrade pip setuptools wheel
  pip3 install --force-reinstall --upgrade pip # point 'pip' to python3 instead of python2
  pip3 install virtualfish

  # create virtualenvironments 
  export WORKON_HOME=~/.virtualenvs
  mkdir -p $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh

  # install pipsi to install scripts into seperate virtualenvs to shield them from your system and each other
  curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
}

install_ruby() {
  brew install ruby
  gem update --system
  gem install --no-document pygments.rb # needed for installing ghi with brew
}

install_haskell() {
# see https://blog.jez.io/2016/08/03/vim-and-haskell-in-2016-on-os-x/
brew install haskell-stack
stack  --resolver=lts-9.11 setup # https://www.stackage.org/snapshots
stack build intero
stack install hlint
}