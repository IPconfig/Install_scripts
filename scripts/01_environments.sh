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
  # Prompts for password
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  # Change to the new shell, prompts for password
  chsh -s /usr/local/bin/bash
}

install_python() {
  brew install python3
  # install some eggs
  pip3 install livestreamer

install_ruby() {
  brew install ruby
  gem update --system
  gem install --no-document pygments.rb # needed for installing ghi with brew
}