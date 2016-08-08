set_default_apps() {
  # fix duplicates in `open with`
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  killall Finder

  # general extensions
  for ext in {aac,avi,f4v,flac,m4a,m4b,mkv,mov,mp3,mp4,mpeg,mpg,wav,webm}; do duti -s io.mpv "${ext}" all; done # media
  for ext in {css,js,json,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}

install_vscode_packages() {
  code --install-extension microsoft.C# cssho.SVG-Viewer
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