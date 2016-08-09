install_brew_apps() {
  brew install ffmpeg --with-faac --with-libvpx --with-libvorbis --with-openssl --with-theora --with-x265
  brew install asciinema asciinema2gif #install terminal screen recorder
  brew install exiftool #R/W exif information
  brew install git git-extras ghi #git from the commandline
  brew install gifify #make gifs from movies
  brew install hr #horizontal ruler for the terminal
  brew install duti #needer later on to set default app for extensions

}

install_cask_apps() {
  brew cask install --appdir='/Applications' cyberduck docker-toolbox dropbox flux github-desktop handbrake malwarebytes-anti-malware microsoft-office onyx postman sequel-pro shotcut steam suspicious-package transmission visual-studio-code whatsapp xact

  # install alternative versions
  brew tap caskroom/versions
  brew cask install --appdir='/Applications' firefox-beta google-chrome-canary pycharm-ce royal-tsx-beta

  # prefpanes, qlplugins, colorpickers
  brew cask install betterzipql colorpicker-skalacolor epubquicklook qlcolorcode qlplayground qlstephen quicklook-json ttscoff-mmd-quicklook qlmarkdown qlprettypatch quicklook-csv webpquicklook
}

install_mas_apps() {
  readonly local mas_apps=('1password=443987910' 'xcode=497799835' 'WiFi Scanner=411680127' 'The Unarchiver=425424353' 'Haskell for Mac=841285201')

  mas signin "${mas_email}" "${mas_password}"

  for app in "${mas_apps[@]}"; do
    local app_id="${app#*=}"
    mas install "${app_id}"
  done
}