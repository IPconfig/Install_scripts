set_default_apps() {
  # fix duplicates in `open with`
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  killall Finder

  # general extensions
#  for ext in {aac,avi,f4v,flac,m4a,m4b,mkv,mov,mp3,mp4,mpeg,mpg,wav,webm}; do duti -s io.mpv "${ext}" all; done # media
  for ext in {css,js,json,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}



hushlogin(){
    #silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 
}

install_fish_plugins() {
  # Install fisherman
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  # Theme
  fisher i oh-my-fish/theme-bobthefish

  fisher edc/bass # Make Bash utilities easy to use in fish
  # Enable nerd fonts Support
  # set -g theme_nerd_fonts yes

  alias showFinder 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFinder 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  alias findDS 'sudo find . -name ".DS_Store"'
  alias noDS 'defaults write com.apple.desktopservices DSDontWriteNetworkStores true'
  alias yesDS 'defaults write com.apple.desktopservices DSDontWriteNetworkStores false'
  alias byeDS 'sudo find . -name ".DS_Store" -exec rm "{}" \;'
  alias brew_update 'brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor'
  funcsave showFinder hideFinder findDS noDS yesDS byeDS
  # set -g fish_user_paths "/usr/local/sbin" $fish_user_paths >> ~/.config/fish/config.fish
}

install_vscode_packages() {
  code --install-extension ms-vscode.csharp donjayamanne.python robertohuertasm.vscode-icons cssho.vscode-svgviewer
}

configure_git() {
  echo -e "[user]\n\tname = ${name}\n\temail = ${github_email}\n[github]\n\tuser = ${github_username}" > "${HOME}/.gitconfig"
  git config --global credential.helper osxkeychain
  git config --global push.default simple
  git config --global rerere.enabled true
  git config --global rerere.autoupdate true
}

lower_startup_chime() {
  curl -fsSL 'https://raw.githubusercontent.com/vitorgalvao/lowchime/master/lowchime' --output '/tmp/lowchime'
  chmod +x '/tmp/lowchime'
  sudo --stdin /tmp/lowchime install <<< "${sudo_password}" 2> /dev/null
}