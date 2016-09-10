install_brew() {
  renew_sudo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
   # disable analytics
  git config --file="$(brew --repository)/.git/config" --replace-all homebrew.analyticsdisabled true
}

install_bash() {
  # Install Bash 4.
  brew install bash
  brew tap homebrew/versions
  brew install bash-completion2
  # We installed the new shell, now we have to activate it
  echo "Adding the newly installed shell to the list of allowed shells"
  sudo -S sh -c 'echo "/usr/local/bin/bash" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo -S chsh -s '/usr/local/bin/bash' "${USER}" <<< "${sudo_password}" 2> /dev/null
  mv /tmp/install_scripts-master/.bash_profile ~/.bash_profile
} 

install_powerline(){
  # Install Powerline-shell
  git clone https://github.com/milkbikis/powerline-shell
  # Enter the powerline-shell directory and copy config.py.dist to config.py. Then run the install.py script.
  cd powerline-shell
  cp config.py.dist config.py
  ./install.py
  # Copy the generated powerline-shell.py to Home directory
  cp powerline-shell.py ~/.powerline-shell.py

  ADDTO_BASHPROFILE (){
    {
      echo ""
      echo "# Load powerline"
      echo "function _update_ps1() {"
      echo $'\t'"export PS1=\"\$(~/.powerline-shell.py \$? 2> /dev/null)\""
      echo "}"
      echo ""
      echo "export PROMPT_COMMAND=\"_update_ps1; \$PROMPT_COMMAND\""
    }
  } >> ~/.bash_profile

  # Change / Setup bash custom prompt (PS1) using powerline
  if grep -q "powerline-shell.py" ~/.bash_profile
  then
    echo "Existing powerline text found in bash_profile, nothing added"
  else
    ADDTO_BASHPROFILE
  fi
  # Clean up the downloaded powerline-shell directory
  cd ..; rm -rf -- powerline-shell
  echo "Powerline added to shell, please logout or restart"
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