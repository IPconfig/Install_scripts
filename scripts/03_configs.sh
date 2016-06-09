set_default_apps() {
  # fix duplicates in `open with`
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  killall Finder

  # general extensions
  for ext in {css,js,json,php,pug,py,rb,sh,txt}; do duti -s com.github.atom "${ext}" all; done # code
}

install_atom_packages() {
  # packages
  apm install atom-alignment color-picker dash esformatter git-plus highlight-line language-pug language-swift linter linter-eslint linter-jsonlint linter-rubocop linter-shellcheck merge-conflicts node-debugger p5xjs-autocomplete pigments relative-numbers seeing-is-believing

  # themes and syntaxes
  apm install atom-material-syntax atam-material-ui
}

install_vscode_packages() {
  code --install-extension dbaeumer.vscode-eslint gerane.Theme-Peacock misogi.ruby-rubocop rebornix.Ruby
}

configure_git() {
  echo -e "[user]\n\tname = ${name}\n\temail = ${github_email}\n[github]\n\tuser = ${github_username}" > "${HOME}/.gitconfig"
  git config --global credential.helper osxkeychain
  git config --global push.default simple
  git config --global rerere.enabled true
  git config --global rerere.autoupdate true
}

install_launchagents() {
  readonly local launchagents_dir="${HOME}/Library/LaunchAgents"
  mkdir -p "${launchagents_dir}"

  for plist_file in "${helper_files}/launchd_plists"/*; do
    readonly local plist_name=$(basename "${plist_file}")

    mv "${plist_file}" "${launchagents_dir}"
    launchctl load -w "${launchagents_dir}/${plist_name}"
  done

  rmdir "${helper_files}/launchd_plists"
}

lower_startup_chime() {
  curl -fsSL 'https://raw.githubusercontent.com/vitorgalvao/lowchime/master/lowchime' --output '/tmp/lowchime'
  chmod +x '/tmp/lowchime'
  sudo -S /tmp/lowchime install <<< "${sudo_password}" 2> /dev/null
}
