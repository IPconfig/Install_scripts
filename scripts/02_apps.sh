install_brew_apps() {
  brew install asciinema asciinema2gif #install terminal screen recorder
  brew install exiftool #R/W exif information
  brew install ghi git git-extras #git from the commandline
  brew install gifify #make gifs from movies
  brew install hr #horizontal ruler for the terminal

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