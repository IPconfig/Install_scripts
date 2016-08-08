Configure_osx_settings() {
# ask for 'sudo' authentication
  if sudo -n true 2> /dev/null; then
    read -s -n0 -p "$(tput bold)Some commands require 'sudo', but it seems you have already authenticated. When you’re ready to continue, press ↵.$(tput sgr0)"
    echo
  else
    echo -n "$(tput bold)When you’re ready to continue, insert your password. This is done upfront for the commands that require 'sudo'.$(tput sgr0) "
    sudo -v
  fi
  # more options on http://mths.be/osx
  info 'Expand save panel by default.'
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  info 'Expand print panel by default.'
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  info 'Save documents to disk (not to iCloud) by default.'
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  info 'Disable shadow in screenshots.'
  defaults write com.apple.screencapture disable-shadow -bool true

  ###############################################################################
  # keyboard & mouse                                                            #
  ###############################################################################
  info 'Enable tap to click for this user.'
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  info 'Enable full keyboard access for all controls.'
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  info 'Disable smart quotes as they’re annoying when typing code'
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  info 'Disable smart dashes as they’re annoying when typing code'
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  ###############################################################################
  # Finder & Dock                                                               #
  ###############################################################################
  info "Disable the 'Are you sure you want to open this application?' dialog."
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  info 'Show all filename extensions in Finder.'
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  info 'Disable the warning when changing a file extension.'
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  info 'Use list view in all Finder windows by default.'
  # Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'
  defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

  info 'Disable the warning before emptying the Trash.'
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  info 'Show the ~/Library folder.'
  chflags nohidden "${HOME}/Library"

  info 'Automatically open a new Finder window when a volume is mounted.'
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

  info 'Display full POSIX path as Finder window title.'
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  info 'Show Path bar in Finder.'
  defaults write com.apple.finder ShowPathbar -bool true

  info 'Show Status bar in Finder.'
  defaults write com.apple.finder ShowStatusBar -bool true

  info 'Use current directory as default search scope in Finder.'
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  info 'Avoid creating .DS_Store files on network volumes.'
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  info 'Set hot corners.'
  # Bottom left screen corner → Desktop
  defaults write com.apple.dock wvous-bl-corner -int 4
  # Top right screen corner → Notification Center
  defaults write com.apple.dock wvous-tr-corner -int 12
  # Bottom right screen corner → Mission Control
  defaults write com.apple.dock wvous-br-corner -int 2

  info 'Expand the file info panels by default'
  # “General”, “Open with”, and “Sharing & Permissions”
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
  	General -bool true \
  	OpenWith -bool true \
  	Privileges -bool true

  ###############################################################################
  # Safari & Networking                                                         #
  ###############################################################################
  info 'Use OpenDNS servers.'
  sudo networksetup -setdnsservers Wi-Fi 208.67.220.220 208.67.222.222

  info 'Enable AirDrop over Ethernet and on unsupported Macs running Lion'
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

  info 'Set up Safari for development.'
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  info 'Privacy: don’t send search queries to Apple.'
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  ###############################################################################
  # Mail                                                                        #
  ###############################################################################
  info 'Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app.'
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  ###############################################################################
  # Activity Monitor                                                            #
  ###############################################################################
  info 'Show the main window when launching Activity Monitor.'
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  info 'Visualize CPU usage in the Activity Monitor Dock icon.'
  defaults write com.apple.ActivityMonitor IconType -int 5

  info 'Show all processes in Activity Monitor.'
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  info 'Sort Activity Monitor results by CPU usage.'
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0


  ###############################################################################
  # Mac App Store                                                               #
  ###############################################################################
  info 'Enable the WebKit Developer Tools in the Mac App Store'
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  info 'Enable Debug Menu in the Mac App Store'
  defaults write com.apple.appstore ShowDebugMenu -bool true

  info 'Check for software updates daily, not just once per week'
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  ###############################################################################
  # Photos                                                                      #
  ###############################################################################
  info 'Prevent Photos from opening automatically when devices are plugged in.'
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  # Kill affected apps
  for app in "Activity Monitor" "Dock" "Finder" "Mail" "Photos" "Safari" "Terminal"; do
    killall "${app}" &> /dev/null
  done

  echo "Done. Note that some of these changes require a logout/restart to take effect."
}