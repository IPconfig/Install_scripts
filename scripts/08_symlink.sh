function symlink_files {
  log_success "Create some required folders."

  # Stow is too smart for its own good. If these files are not created outside, it
  # will manage the while folder which means I will get everything in my dotfiles
  # repo git history. Too much noise & not really scalable, the fix? create the
  # folders manually.
  mkdir -p $HOME/.mail/{Personal,Work,.notmuch} $HOME/.{ssh,gnupg,config} $HOME/Library/LaunchAgents

  if [[ -d $DOTFILES_DIR ]]; then
    log_success "Symlinking files/folders."
    # I want all the make steps to run even if a cask or a brew errored out
    cd "$DOTFILES_DIR" &&
      cp files/.gitconfig.local $HOME/.gitconfig.local &&
      cp files/.zshrc.local $HOME/.zshrc.local &&
      make symlink
  else
    log_error "There is no $DOTFILES_DIR directory."
  fi
}