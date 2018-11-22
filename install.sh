run_install_dotfiles() {
  curl --progress-bar --location 'https://github.com/IPconfig/install_scripts/archive/master.zip' | ditto -xk - '/tmp'

  # source all shell scripts
  for shell_script in '/tmp/install_scripts-master/scripts/'*.sh; do
    source "${shell_script}"
  done

  clear

  update_system
  initial_setup
  ask_details

  install_brew
  # install_fish
  install_zsh
  
  # install_python
  install_anaconda
  install_ruby
  install_haskell

  install_brew_apps
  install_cask_apps
  install_mas_apps

  set_default_apps
  hushlogin
  install_vscode_packages
  configure_git
  lower_startup_chime

  Configure_macOS_settings

  cleanup_brew
  cleanup_error_log
  killall caffeinate # computer can go back to sleep
  final_message
}

# run and log errors to file (but still show them when they happen)
readonly error_log="${HOME}/Desktop/install_errors.log"
run_install_dotfiles 2> >(tee "${error_log}")
