set_default_apps() {
  # general extensions
  for ext in {css,html,js,json,md,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}


hushlogin(){
  # Silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 
}


install_fish_plugins() {
  # Install fisherman
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  set --export PATH $HOME/.local/bin $PATH # Needed for Hakyll-Init
  fisher up
  fisher bass # Make Bash utilities easy to use in fish
  fisher pipenv
  fisher docker-completion
  brew install grc; fisher grc

  # Theme
  fisher bobthefish
  set -g theme_nerd_fonts yes
  set -g theme_color_scheme solarized-dark
  set -x VIRTUAL_ENV_DISABLE_PROMPT 1
  set -U fish_key_bindings fish_vi_key_bindings

  alias showFinder 'defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hideFinder 'defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
  alias findDS 'sudo find . -name ".DS_Store"'
  alias noDS 'defaults write com.apple.desktopservices DSDontWriteNetworkStores true'
  alias yesDS 'defaults write com.apple.desktopservices DSDontWriteNetworkStores false'
  alias byeDS 'sudo find . -name ".DS_Store" -exec rm "{}" \;'
  alias brew_update 'brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor'
  alias ls 'ls -lhFG'
  alias df 'df -H' # Displays disk free space
  alias grep 'grep --color=always -I' # Colorful grep that ignores binary file and outputs line number

  funcsave showFinder hideFinder findDS noDS yesDS byeDS brew_update ls df grep
  fish_update_completions
}

install_vscode_packages() {
  code --install-extension ms-python.python vans.haskero robertohuertasm.vscode-icons
}

configure_git() {
  git config --global user.name "${name}"
  git config --global user.email "${github_email}"
  git config --global github.user "${github_username}"
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