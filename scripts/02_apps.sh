#Helper functions
brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  brew list -1 | grep -Fqx "$1"
}

brew_is_upgradable() {
  ! brew outdated --quiet "$1" >/dev/null
}
#-----------------

install_brew_apps() {
  brew_install_or_upgrade asciinema asciinema2gif #install terminal screen recorder
  brew_install_or_upgrade exiftool #R/W exif information
  brew_install_or_upgrade ghi git git-extras #git from the commandline
  brew_install_or_upgrade gifify #make gifs from movies
  brew_install_or_upgrade hr #horizontal ruler for the terminal
  brew_install_or_upgrade duti #needer later on to set default app for extensions

  # install and configure tor
  #brew install tor torsocks
  #cp "$(brew --prefix)/etc/tor/torrc.sample" "$(brew --prefix)/etc/tor/torrc"
  #echo 'ExitNodes {us}' >> "$(brew --prefix)/etc/tor/torrc"
}

install_cask_apps() {
  brew cask install --appdir='/Applications' cyberduck docker-toolbox drop-to-gif dropbox flux github-desktop handbrake malwarebytes-anti-malware microsoft-office onyx postman pycharm-ce sequel-pro screenflow shotcut steam torbrowser transmission visual-studio-code whatsapp xact wwdc

  # install alternative versions
  brew tap caskroom/versions
  brew cask install --appdir='/Applications' firefox-beta google-chrome-canary royal-tsx-beta

  # prefpanes, qlplugins, colorpickers
  brew cask install betterzipql colorpicker-skalacolor epubquicklook qlcolorcode qlplayground qlstephen quicklook-json ttscoff-mmd-quicklook qlmarkdown qlprettypatch quicklook-csv webpquicklook suspicious-package
}

install_mas_apps() {
  readonly local mas_apps=('1password=443987910' 'xcode=497799835' 'WiFi Scanner=411680127' 'The Unarchiver=425424353' 'Haskell=841285201')

  mas signin "${mas_email}" "${mas_password}"

  for app in "${mas_apps[@]}"; do
    local app_id="${app#*=}"
    mas install "${app_id}"
  done
}