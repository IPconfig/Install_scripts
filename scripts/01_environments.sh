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

  #silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 

  configure_bash() {
      {
        echo "# Bash completion"
        echo "if [ -f /etc/bash_completion ] && ! shopt -oq posix; then"
        echo "  . /etc/bash_completion"
        echo "fi"

        # Use Nano as default texteditor since I hate vim (Sorry)  
        echo "export EDITOR=/usr/bin/nano"
        echo "" 

        # timestamps for later analysis. www.debian-administration.org/users/rossen/weblog/1
        echo "export HISTTIMEFORMAT='%F %T '"
        # keep history up to date, across sessions, in realtime
        #  http://unix.stackexchange.com/a/48113
        echo "export HISTCONTROL=ignoredups:erasedups         # no duplicate entries"
        echo "export HISTSIZE=100000                          # big big history (default is 500)"
        echo "export HISTFILESIZE=\$HISTSIZE\                  # big big history"
        echo "which shopt > /dev/null && shopt -s histappend  # append to history, don't overwrite it"

        echo "# Save and reload the history after each command finishes"
        #TODO: fix PROMPT_COMMAND; also used by powerline
        echo "export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND""
        echo "# ^ the only downside with this is [up] on the readline will go over all history not just this bash session."
      }
    } >> ~/.bash_profile

  # Configure Bash_History
  if grep -q "HISTSIZE=100000 " ~/.bash_profile
  then
    echo "Existing bash_history found in bash_profile, nothing added"
  else
    configure_bash
  fi
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

install_powerline() {
  SHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
  # Install fonts for powerline-shell
  echo "Install fonts for powerline-shell"
  sh "$SHDIR/fonts/install.sh"

  # Install Powerline-shell
  echo "Installing and Configuring Powerline-shell"
  # Clone from https://github.com/milkbikis/powerline-shell
  git clone https://github.com/milkbikis/powerline-shell
  # Enter the powerline-shell directory and copy config.py.dist to config.py. Then run the install.py script.
  cd powerline-shell
  cp config.py.dist config.py
  ./install.py
  # Copy the generated powerline-shell.py to Home directory
  cp powerline-shell.py ~/powerline-shell.py

  ADDTO_BASHPROFILE ()
  {
    {
    echo ""
    echo "# Load powerline"
    echo "function _update_ps1() {"
    echo $'\t'"export PS1=\"\$(~/powerline-shell.py \$? 2> /dev/null)\""
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