#!/bin/bash

# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eueo pipefail

export PATH="/usr/local/bin:${PATH}"
trap 'exit 0' SIGINT # exit cleanly if aborted with ⌃C
caffeinate & # Prevent computer from going to sleep

# 
tmp_dir="$(mktemp -d)"
curl --location 'https://github.com/IPconfig/install_scripts/archive/master.zip' | ditto -xk - "${tmp_dir}"
for shell_script in "${tmp_dir}/dotfiles-master/scripts/"*.sh; do
  source "${shell_script}"
done


# Setting some variables
DOTFILES_DIR="$HOME/.dotfiles"


function show_options {
  clear

  echo "
    What do you want to do next?
    [1] Update the system.
    [2] Configure macOS.
    [3] Setup language environments.
    [4] Install apps.
    [5] Configure tools.
    [6] Clone dotfiles.
    [7] Backup old dotfiles.
    [8] Symlink dotfiles.
    [0] Quit.
  " | sed -E 's/ {4}//'

  read -n1 -rp 'Pick a number: ' option
  clear

  if [[ "${option}" -eq 1 ]]; then
    mas_login
    update_system
  elif [[ "${option}" -eq 2 ]]; then
    Configure_macOS
    set_lock_screen_message
    lower_startup_chime
  elif [[ "${option}" -eq 3 ]]; then
    install_homebrew
    install_python
    install_node
    install_java
    # install_haskell
    install_julia
  elif [[ "${option}" -eq 4 ]]; then
    install_brew_apps
    install_cask_apps
    install_mas_apps
  elif [[ "${option}" -eq 5 ]]; then
    set_default_apps
    configure_zsh
    configure_git
    install_editor_packages
  elif [[ "${option}" -eq 6 ]]; then
    # clone_dotfiles
    show_options
  elif [[ "${option}" -eq 7 ]]; then
    # take_backup
    show_options
  elif [[ "${option}" -eq 8 ]]; then
    # symlink_files
    show_options
  elif [[ "${option}" -eq 0 ]]; then
    # Let computer go to sleep again
    # Using the `pid` and `wait` with redirection prevents the `Terminated` message
    local caffeinate_pid="$(pgrep caffeinate)"
    kill "${caffeinate_pid}"
    wait "${caffeinate_pid}" 2>/dev/null

    sudo --remove-timestamp

    return 0
  else
    echo 'Not a valid option. Try again.' >&2
  fi

  show_options
}

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

# =======================================================================
# = Run!
# =======================================================================
function run() {
  print_main_banner
  show_options
}

run