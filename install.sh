run_install_dotfiles() {
  curl --progress-bar --location 'https://github.com/IPconfig/install_scripts/archive/master.zip' | ditto -xk - '/tmp'

  # source all shell scripts
  for shell_script in '/tmp/install_scripts-master/scripts/'*.sh; do
    source "${shell_script}"
  done

  clear

  initial_setup
  ask_details
  install_xcode
  update_system

  install_brew
  #install_bash
  install_python

  install_brew_apps
  make_caskroom
  install_cask_apps
  install_mas_apps

  set_default_apps
  install_atom_packages
  install_vscode_packages
  configure_git
  lower_startup_chime

  Configure_osx_settings

  cleanup_brew
  cleanup_error_log
  killall caffeinate # computer can go back to sleep
  final_message
}

# run and log errors to file (but still show them when they happen)
readonly error_log="${HOME}/Desktop/install_errors.log"
run_install_dotfiles 2> >(tee "${error_log}")
