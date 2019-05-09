function mas_login {
  ask_gui 'Login to the App Store.' 'App Store'
}

function update_system {
  log_info 'Updating macOS. If this requires a restart, run the script again.'
  softwareupdate --install --all
}