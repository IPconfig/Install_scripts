function take_backup {
  log_success "Taking backups for old files."

  local BAKCUP_DIR="$HOME/.dotbackup/$(date "+%Y.%m.%d_%H.%M")"
  mkdir -p "$BAKCUP_DIR"

  # [TODO]: Look into how to automate this list
  local FILES=(
    ".config/newsboat"
    ".config/nvim"
    ".ctags"
    ".curlrc"
    ".editorconfig"
    ".gemrc"
    ".gitattributes"
    ".gitconfig"
    ".gitignore"
    ".grc"
    ".gvimrc"
    ".hammerspoon"
    ".hushlogin"
    ".ignore"
    ".lbdbrc"
    ".mbsyncrc"
    ".msmtprc"
    ".mutt"
    ".notmuch-config"
    ".pip.conf"
    ".pyrc.py"
    ".terminfo"
    ".tern-config"
    ".tigrc"
    ".tmux.conf"
    ".urlview"
    ".vim"
    ".vimrc"
    ".zlogin"
    ".zprofile"
    ".zshenv"
    ".zshrc"
  )

  for file in "${FILES[@]}"; do
    local ITEM="$HOME/$file"

    # [[]] doesn't require quotes around single variables in fact it fails with double quotes around variables
    # https://stackoverflow.com/a/4665080/213124
    if [[ -e $ITEM ]]; then
      echo "Backing up: $ITEM"
      mv "$ITEM" "$BAKCUP_DIR"
    fi
  done
}