function clone_dotfiles {
  if [[ ! -d $DOTFILES_DIR ]]; then
    log_success "Cloning dotfiles."
    git clone --recursive https://github.com/ahmedelgabri/dotfiles.git "$DOTFILES_DIR"

    # Setup repo origin & mirrors
    cd "$DOTFILES_DIR" &&
      git remote set-url origin git@github.com:ahmedelgabri/dotfiles.git &&
      git remote add --mirror=push bitbucket git@bitbucket.org:ahmedelgabri/dotfiles.git &&
      git remote add --mirror=push gitlab git@gitlab.com:ahmedelgabri/dotfiles.git
  else
    cd "$DOTFILES_DIR" &&
      git stash -u &&
      git checkout master &&
      git reset --hard origin/master &&
      git submodule update --init --recursive &&
      git checkout - &&
      git stash pop
  fi
}