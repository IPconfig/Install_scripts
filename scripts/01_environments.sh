install_brew() {
  renew_sudo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  # Disable analytics
  brew analytics off
}

install_fish(){
  brew install fish
  sudo -S sh -c 'echo "/usr/local/bin/fish" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo -S chsh -s '/usr/local/bin/fish' "${USER}" <<< "${sudo_password}" 2> /dev/null
}

install_python() {
  brew install python # this will already prefer the brewed one above the system installed one
  pip install --upgrade pip

  #python3
  brew install python3
  pip3 install --upgrade pip3
  pip3 install virtualfish

  # create virtualenvironments 
  export WORKON_HOME=~/.virtualenvs
  mkdir -p $WORKON_HOME
  source /usr/local/bin/virtualenvwrapper.sh
}

install_ruby() {
  brew install ruby
  gem update --system
  gem install --no-document pygments.rb # needed for installing ghi with brew
}