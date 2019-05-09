# Helper variables
tput sgr0
RED=$(tput setaf 1)
ORANGE=$(tput setaf 3)
GREEN=$(tput setaf 2)
PURPLE=$(tput setaf 5)
BLUE=$(tput setaf 4)
WHITE=$(tput setaf 7)
BOLD=$(tput bold)
RESET=$(tput sgr0)

log() {
  local LABEL="[$1]"
  local COLOR="$2"
  shift
  shift
  local MSG=("$@")
  printf "${COLOR}${LABEL}%*s${RESET}" $(($(tput cols) - ${#LABEL})) | tr ' ' '='
  for M in "${MSG[@]}"; do
    let COL=$(tput cols)-2-${#M}
    printf "%s%${COL}s${RESET}" "$COLOR* $M"
  done
  printf "${COLOR}%*s${RESET}\n\n\n" $(tput cols) | tr ' ' '='
}

log_error() {
  log "FAIL" "$RED" "$@"
  exit 1
}

log_info() {
  log "INFO" "$ORANGE" "$@"
}

log_success() {
  log "OK" "$GREEN" "$@"
}

get_permission() {
  # Ask for the administrator password upfront.
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until the script has finished.
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
}

print_main_banner() {
  cd "$HOME"
  command cat <<EOF
$BLUE
                            _       _    __ _ _
                           | |     | |  / _(_) |
                         __| | ___ | |_| |_ _| | ___  ___
                        / _. |/ _ \| __|  _| | |/ _ \/ __|
                       | (_| | (_) | |_| | | | |  __/\__ \ $()
                      (_)__,_|\___/ \__|_| |_|_|\___||___/
$RESET
EOF

  if [ -d "$DOTFILES_DIR/.git" ]; then
    command cat <<EOF
$BLUE
                      $RESET~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$BLUE
                      $RESET$BLUE
                      $RESET   $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(yellow)commit:  %h') $BLUE
                      $RESET   $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(red)date:    %ad' --date=short) $BLUE
                      $RESET   $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(cyan)author:  %an') $BLUE
                      $RESET   $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(green)message: %s') $BLUE
                      $RESET$BLUE
                      $RESET~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$BLUE
$RESET
EOF
  fi
}


function message {
  local bullet_color="${1}"
  local message="${2}"
  local all_colors=('black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white')

  for i in "${!all_colors[@]}"; do
    if [[ "${all_colors[${i}]}" == "${bullet_color}" ]]; then
      local color_index="${i}"
      echo -e "$(tput setaf "${i}")•$(tput sgr0) ${message}"
      break
    fi
  done

  if [[ -z "${color_index}" ]]; then
    echo "${FUNCNAME[0]}: '${bullet_color}' is not a valid color."
    return 1
  fi
}

# Ask for info to be given in the Terminal
function ask {
  message 'magenta' "${1}"
}

# Ask for a manual GUI action to be done
function ask_gui {
  local message="${1}"
  local app="${2}"
  shift 2

  ask "${message}"
  open -Wa "${app}" --args "${@}" # Do not continue until app closes
}
