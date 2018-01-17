  #!/usr/local/bin/fish
  # Install fisherman
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  set --export PATH $HOME/.local/bin $PATH # Needed for Hakyll-Init
  fisher up
  fisher await
  fisher bass # Make Bash utilities easy to use in fish
  fisher docker-completion
  fisher pipenv
  brew install grc; fisher grc # generic colourizer

  # Theme
  fisher bobthefish
  set -g theme_nerd_fonts yes
  set -g theme_color_scheme solarized-dark
  set -x VIRTUAL_ENV_DISABLE_PROMPT 1
  set -U fish_key_bindings fish_vi_key_bindings

  # Allow 256 colors in iTerm2 for pretty vim colors
  set -gx CLICOLOR 1
  set -gx TERM xterm-256color

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
  alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

  funcsave showFinder hideFinder findDS noDS yesDS byeDS brew_update ls df grep ip
  fish_update_completions