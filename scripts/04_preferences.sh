Configure_macOS_settings() {
# ask for 'sudo' authentication
  if sudo -n true 2> /dev/null; then
    read -s -n0 -p "$(tput bold)Some commands require 'sudo', but it seems you have already authenticated. When you’re ready to continue, press ↵.$(tput sgr0)"
    echo
  else
    echo -n "$(tput bold)When you’re ready to continue, insert your password. This is done upfront for the commands that require 'sudo'.$(tput sgr0) "
    sudo -v
  fi
  # more options on http://mths.be/osx

  ###############################################################################
  # General                                                                     #
  ###############################################################################
  echo 'Expand save panel by default.'
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  echo 'Expand print panel by default.'
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  echo 'Save documents to disk (not to iCloud) by default.'
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  echo 'Disable shadow in screenshots.'
  defaults write com.apple.screencapture disable-shadow -bool true

  ###############################################################################
  # keyboard & mouse                                                            #
  ###############################################################################
  echo 'Enable tap to click for this user.'
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  echo 'Enable full keyboard access for all controls.'
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  echo 'Disable smart quotes as they’re annoying when typing code'
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  echo 'Disable smart dashes as they’re annoying when typing code'
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  ###############################################################################
  # Finder & Dock                                                               #
  ###############################################################################
  echo "Disable the 'Are you sure you want to open this application?' dialog."
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  echo 'Use list view in all Finder windows by default.'
  # Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'
  defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

  echo 'Disable the warning before emptying the Trash.'
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  echo 'Show the ~/Library folder.'
  chflags nohidden "${HOME}/Library"

  echo 'Automatically open a new Finder window when a volume is mounted.'
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

  echo 'Display full POSIX path as Finder window title.'
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  echo 'Show Path bar in Finder.'
  defaults write com.apple.finder ShowPathbar -bool true

  echo 'Show Status bar in Finder.'
  defaults write com.apple.finder ShowStatusBar -bool true

  echo 'Use current directory as default search scope in Finder.'
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  echo 'Avoid creating .DS_Store files on network volumes.'
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  #echo 'Add a recently used applications folder to dock'
  #defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

  echo 'Set hot corners.'
  # Bottom left screen corner → Desktop
  defaults write com.apple.dock wvous-bl-corner -int 4
  # Top right screen corner → Notification Center
  # defaults write com.apple.dock wvous-tr-corner -int 12
  # Bottom right screen corner → Mission Control
  defaults write com.apple.dock wvous-br-corner -int 2

  echo 'Expand the file echo panels by default.'
  # “General”, “Open with”, and “Sharing & Permissions”
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
  	General -bool true \
  	OpenWith -bool true \
  	Privileges -bool true

  ###############################################################################
  # Safari & Networking, Privacy                                                #
  ###############################################################################
  echo 'Use OpenDNS servers.'
  sudo networksetup -setdnsservers Wi-Fi 208.67.220.220 208.67.222.222

  echo 'Enable AirDrop over Ethernet and on unsupported Macs running Lion'
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

  echo 'Set up Safari for development.'
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  echo 'Show the full URL in the adress bar'
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  echo 'Show status bar'
  defaults write com.apple.Safari ShowStatusBar -bool true

  echo 'Show favorites bar'
  defaults write com.apple.Safari ShowFavoritesBar -bool true
  defaults write com.apple.Safari "ShowFavoritesBar-v2" -bool true

  echo 'show tab bar'
  defaults write com.apple.Safari AlwaysShowTabBar -bool true

  echo 'Privacy: don’t send search queries to Apple.'
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  # Do not track
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

  # Update extensions automatically
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

  ###############################################################################
  # Mail                                                                        #
  ###############################################################################
  echo 'Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app.'
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

  ###############################################################################
  # Activity Monitor                                                            #
  ###############################################################################
  echo 'Show the main window when launching Activity Monitor.'
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  echo 'Visualize CPU usage in the Activity Monitor Dock icon.'
  defaults write com.apple.ActivityMonitor IconType -int 5

  echo 'Show all processes in Activity Monitor.'
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  echo 'Sort Activity Monitor results by CPU usage.'
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0


  ###############################################################################
  # Mac App Store                                                               #
  ###############################################################################
  echo 'Enable the WebKit Developer Tools in the Mac App Store.'
  defaults write com.apple.appstore WebKitDeveloperExtras -bool true

  echo 'Enable Debug Menu in the Mac App Store.'
  defaults write com.apple.appstore ShowDebugMenu -bool true

  echo 'Check for software updates daily, not just once per week.'
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  ###############################################################################
  # Photos                                                                      #
  ###############################################################################
  echo 'Prevent Photos from opening automatically when devices are plugged in.'
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  ###############################################################################
  # Disk Utility                                                                #
  ###############################################################################
  echo 'Setting Disk Utility preferences.'
  # Enable the debug menu in Disk Utility
  defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  defaults write com.apple.DiskUtility advanced-image-options -bool true
  CFPreferencesAppSynchronize "com.apple.DiskUtility"

  ###############################################################################
  # Terminal                                                                    #
  ###############################################################################
 # echo 'Only use UTF-8 in Terminal.app'
 # defaults write com.apple.terminal StringEncodings -array 4

#   echo 'Use a modified version of the Solarized Dark theme by default in Terminal.app'

# osascript <<EOD

# tell application "Terminal"

# 	local allOpenedWindows
# 	local initialOpenedWindows
# 	local windowID
# 	set themeName to "Solarized Dark xterm-256color"

# 	(* Store the IDs of all the open terminal windows. *)
# 	set initialOpenedWindows to id of every window

# 	(* Open the custom theme so that it gets added to the list
# 	   of available terminal themes (note: this will open two
# 	   additional terminal windows). *)
# 	do shell script "open '/tmp/install_scripts-master/theme/" & themeName & ".terminal'"

# 	(* Wait a little bit to ensure that the custom theme is added. *)
# 	delay 1

# 	(* Set the custom theme as the default terminal theme. *)
# 	set default settings to settings set themeName

# 	(* Get the IDs of all the currently opened terminal windows. *)
# 	set allOpenedWindows to id of every window

# 	repeat with windowID in allOpenedWindows

# 		(* Close the additional windows that were opened in order
# 		   to add the custom theme to the list of terminal themes. *)
# 		if initialOpenedWindows does not contain windowID then
# 			close (every window whose id is windowID)

# 		(* Change the theme for the initial opened terminal windows
# 		   to remove the need to close them in order for the custom
# 		   theme to be applied. *)
# 		else
# 			set current settings of tabs of (every window whose id is windowID) to settings set themeName
# 		end if

# 	end repeat

# end tell

# EOD

  # Kill affected apps
  for app in "Activity Monitor" "Dock" "Disk Utility" "Finder" "Mail" "Photos" "Safari"; do
    killall "${app}" &> /dev/null
  done

  echo "Done. Note that some of these changes require a logout/restart to take effect."
}