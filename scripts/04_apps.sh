function install_brew_apps {
  log_info 'Installing Homebrew packages.'
  brew install ffmpeg --with-faac --with-libvpx --with-libvorbis --with-openssl --with-theora --with-x265
  brew install asciinema asciinema2gif # install terminal screen recorder
  brew install exiftool # R/W exif information
  brew install git git-extras ghi # git from the commandline
  brew install ctags
  brew install hr # horizontal ruler for the terminal
  brew install duti # needed later to set default app for extensions
  brew install mas # mac app store from the command line
  brew install zsh # a better shell

  log_info 'Installing Homebrew ZSH plugins.'
  brew install zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting
}

function install_cask_apps {
  get_permission # to make the Caskroom on first install
  log_info 'Installing casks.'
  brew cask install dropbox github handbrake iina onyx steam telegram tunnelblick visual-studio-code whatsapp xact

  log_info 'Installing cask versions.'
  brew tap homebrew/cask-versions
  brew cask install firefox-beta

  log_info 'Installing prefpanes, qlplugins, colorpickers.'
  brew cask install epubquicklook qlcolorcode qlimagesize qlstephen ttscoff-mmd-quicklook qlmarkdown qlplayground qlprettypatch qlvideo quicklook-csv quicklook-json

  brew tap homebrew/cask-fonts
  brew cask install font-fira-code # see https://github.com/tonsky/FiraCode
}



function install_mas_apps {
  log_info 'Installing Mac App Store Apps.'
  local mas_apps=('1password=443987910' 'WiFi Scanner=411680127' 'The Unarchiver=425424353')

  for app in "${mas_apps[@]}"; do
    local app_id="${app#*=}"
    mas install "${app_id}"
  done
}