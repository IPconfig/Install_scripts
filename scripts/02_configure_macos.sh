function Configure_macOS {
get_permission
# more options on http://mths.be/osx

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

  ###############################################################################
  # General                                                                     #
  ###############################################################################
  log_info 'Disable the sound effects on boot'
  sudo nvram SystemAudioVolume=" "

  log_info 'Expand save panel by default.'
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  log_info 'Expand print panel by default.'
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  log_info 'Save documents to disk (not to iCloud) by default.'
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  log_info 'Disable shadow in screenshots.'
  defaults write com.apple.screencapture disable-shadow -bool true

  log_info 'Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window'
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

  log_info '# Do not show password hints.'
  sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

  log_info 'Disable guest account login.'
  sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

  ###############################################################################
  # keyboard & mouse                                                            #
  ###############################################################################
  log_info 'Enable tap to click for this user and for the login screen.'
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  log_info 'Enable full keyboard access for all controls.'
  # (e.g. enable Tab in modal dialogs)
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

  log_info 'Disable smart quotes as they’re annoying when typing code.'
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  log_info 'Disable smart dashes as they’re annoying when typing code.'
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  ###############################################################################
  # Finder & Dock                                                               #
  ###############################################################################
  log_info "Disable the 'Are you sure you want to open this application?' dialog."
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  log_info 'Use list view in all Finder windows by default.'
  # Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'
  defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

  log_info 'Disable the warning before emptying the Trash.'
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  log_info 'Show the ~/Library folder, hide the public folder'
  chflags nohidden "${HOME}/Library"
  chflags hidden "${HOME}/Public"

  log_info 'Set Home as the default location for new Finder windows.'
  defaults write com.apple.finder NewWindowTarget -string 'PfLo'
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

  log_info 'Automatically open a new Finder window when a volume is mounted.'
  defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
  defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
  defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

  log_info 'Enable snap-to-grid for icons on the desktop and in other icon views.'
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist 

  log_info 'Display full POSIX path as Finder window title.'
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  log_info 'Show Path bar in Finder.'
  defaults write com.apple.finder ShowPathbar -bool true

  log_info 'Show Status bar in Finder.'
  defaults write com.apple.finder ShowStatusBar -bool true

  log_info 'Use current directory as default search scope in Finder.'
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  log_info 'Avoid creating .DS_Store files on network or USB volumes.'
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  log_info 'Set hot corners.'
  # Bottom left screen corner → Desktop
  defaults write com.apple.dock wvous-bl-corner -int 4
  # Top right screen corner → Notification Center
  # defaults write com.apple.dock wvous-tr-corner -int 12
  # Bottom right screen corner → Mission Control
  defaults write com.apple.dock wvous-br-corner -int 2

  log_info 'Expand the file log_info panels by default.'
  # “General”, “Open with”, and “Sharing & Permissions”
  defaults write com.apple.finder FXInfoPanesExpanded -dict \
  	General -bool true \
  	OpenWith -bool true \
  	Privileges -bool true

  log_info 'Don’t show recent applications in Dock'
  defaults write com.apple.dock show-recents -bool false

  ###############################################################################
  # Safari & Networking, Privacy                                                #
  ###############################################################################
  log_info 'Privacy: don’t send search queries to Apple'
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  log_info 'Enable AirDrop over Ethernet and on unsupported Macs running Lion'
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

  log_info 'Set up Safari for development.'
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  log_info 'Show the full URL in the adress bar'
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  log_info 'Show status bar'
  defaults write com.apple.Safari ShowStatusBar -bool true

  log_info 'Show favorites bar'
  defaults write com.apple.Safari ShowFavoritesBar -bool true
  defaults write com.apple.Safari "ShowFavoritesBar-v2" -bool true

  log_info 'show tab bar'
  defaults write com.apple.Safari AlwaysShowTabBar -bool true

  log_info 'Privacy: don’t send search queries to Apple.'
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  log_info 'Enable "Do not track".'
  defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

  log_info 'Deny location services access from websites.'
  defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 0

  log_info 'Update extensions automatically.'
  defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

  ###############################################################################
  # Mail                                                                        #
  ###############################################################################
  log_info 'Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app.'
  defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
  
  log_info 'Display emails in threaded mode, sorted by date (oldest at the top)'
  defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
  defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
  defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

  log_info 'Disable inline attachments (just show the icons)'
  defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
  ###############################################################################
  # Activity Monitor                                                            #
  ###############################################################################
  log_info 'Show the main window when launching Activity Monitor.'
  defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

  log_info 'Visualize CPU usage in the Activity Monitor Dock icon.'
  defaults write com.apple.ActivityMonitor IconType -int 5

  log_info 'Show all processes in Activity Monitor.'
  defaults write com.apple.ActivityMonitor ShowCategory -int 0

  log_info 'Sort Activity Monitor results by CPU usage.'
  defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
  defaults write com.apple.ActivityMonitor SortDirection -int 0

  ###############################################################################
  # Time Machine                                                                #
  ###############################################################################
  log_info 'Prevent Time Machine from prompting to use new hard drives as backup volume.'
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  ###############################################################################
  # Mac App Store                                                               #
  ###############################################################################
  log_info 'Check for software updates daily, not just once per week.'
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

  ###############################################################################
  # Photos                                                                      #
  ###############################################################################
  log_info 'Prevent Photos from opening automatically when devices are plugged in.'
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

  ###############################################################################
  # Disk Utility                                                                #
  ###############################################################################
  log_info 'Setting Disk Utility preferences.'
  # Enable the debug menu in Disk Utility
  defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
  defaults write com.apple.DiskUtility advanced-image-options -bool true

  ###############################################################################
  # Terminal                                                                    #
  ###############################################################################
 # log_info 'Only use UTF-8 in Terminal.app'
 # defaults write com.apple.terminal StringEncodings -array 4

log_info 'Use a modified version of the Solarized Dark theme by default in Terminal.app'

osascript <<EOD

tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Solarized Dark"

	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window

	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '/tmp/install_scripts-master/theme/" & themeName & ".terminal'"

	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1

	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName

	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows

		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)

		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat

end tell

EOD

  # Kill affected apps
  for app in "Activity Monitor" "Dock" "Disk Utility" "Finder" "Mail" "Photos" "Safari"; do
    killall "${app}" &> /dev/null
  done

  log_info "Done. Note that some of these changes require a logout/restart to take effect."
}


function set_lock_screen_message {
  local email telephone
  get_permission

  ask 'Give contact information to be set in the lock screen:'
  read -rp 'Email address: ' email
  read -rp 'Telephone number: ' telephone
  sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText -string "$(echo -e "If found, please contact:\nEmail: ${email}\nTel: ${telephone}")"
}


function hushlogin {
  # Silence the last login time in terminal
  cp /tmp/install_scripts-master/files/.hushlogin $HOME/.hushlogin 
}

function lower_startup_chime {
  get_permission
  log_info 'Ensuring a low volume of the startup chime.'
  chmod +x '/tmp/install_scripts-master/files/lowchime'
  sudo /tmp/install_scripts-master/files/lowchime install
}