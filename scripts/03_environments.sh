function install_homebrew {
  get_permission
  if ! command -v brew >/dev/null; then
    log_success "Installing Homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
    brew install stow
  else
    log_info "Homebrew is already installed."
  fi
}


function install_python {
  log_info 'Installing Python and eggs.'

  rm -rf "${HOME}/.pyenv" # Get rid of previous install, if any
  brew install pyenv

  pyenv install "$(pyenv install --list | sed 's/^  //' | grep '^\d' | grep --invert-match 'dev\|a\|b' | tail -1)" # Install latest stable python
  pyenv global "$(pyenv versions | tail -1 | sed 's/^[\* ]*//;s/ .*//')" # Switch to latest installed python
  eval "$(pyenv init -)" # Activate pyenv

  # Install some eggs
  pip install flake8
}

function install_java {
  brew cask install java
}

function install_node {
  log_info 'Installing Node and packages.'

  rm -rf "${HOME}/.nvm" # Get rid of previous install, if any
  brew install nvm

  # Activate nvm
  mkdir "${HOME}/.nvm"
  export NVM_DIR="${HOME}/.nvm"
  [ -s '/usr/local/opt/nvm/nvm.sh' ] && source '/usr/local/opt/nvm/nvm.sh'

  nvm install node # Install latest node

  # Install some packages
  npm install --global eslint eslint-plugin-immutable jsonlint prettier
}

function install_haskell {
brew install haskell-stack
stack --resolver=lts-13.20 setup # https://www.stackage.org/snapshots
stack build intero
stack install hlint
}

function install_julia {
  brew cask install julia

}