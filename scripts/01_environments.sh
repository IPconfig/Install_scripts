install_brew() {
  renew_sudo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
  # Disable analytics
  brew analytics off
}

install_bash() {
  mv /tmp/install_scripts-master/.bash_profile ~/.bash_profile
  # Install Bash 4 and configure preferences.
  brew install bash
  brew tap homebrew/versions
  brew install bash-completion2
  # We installed the new shell, now we have to activate it
  sudo -S sh -c 'echo "/usr/local/bin/bash" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo -S chsh -s '/usr/local/bin/bash' "${USER}" <<< "${sudo_password}" 2> /dev/null
} 




install_zsh(){
  brew install zsh
  echo "Installing zplug..."
  export ZPLUG_HOME=~/.zplug
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source $ZPLUG_HOME/init.zsh
  zplug update --self
  
  #load preferences
  mv /tmp/install_scripts-master/.zshrc ~/.zshrc
install_fish(){
  brew install fish
  sudo -S sh -c 'echo "/usr/local/bin/fish" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo -S chsh -s '/usr/local/bin/fish' "${USER}" <<< "${sudo_password}" 2> /dev/null
}

  install_fish(){
    brew install fish
    sudo -S sh -c 'echo "/usr/local/bin/fish" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
    sudo -S chsh -s '/usr/local/bin/fish' "${USER}" <<< "${sudo_password}" 2> /dev/null
  }

install_python() {
  brew install python # this will already prefer the brewed one above the system installed one
  pip install --upgrade pip
  # install some eggs
  pip install virtualenv virtualenvwrapper

  #python3
  brew install python3
  pip3 install --upgrade pip3

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

install_powerline_fonts() {
  # Install fonts for powerline-shell or zsh
  git clone https://github.com/powerline/fonts
  sh "${HOME}/fonts/install.sh"
  rm -rf -- fonts
}