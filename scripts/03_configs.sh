set_default_apps() {
  # fix duplicates in `open with`
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  killall Finder

  # general extensions
#  for ext in {aac,avi,f4v,flac,m4a,m4b,mkv,mov,mp3,mp4,mpeg,mpg,wav,webm}; do duti -s io.mpv "${ext}" all; done # media
  for ext in {css,js,json,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}



hushlogin(){
    #silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 
}

configure_zsh() { # make zsh default shell
  sudo -S sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells' <<< "${sudo_password}" 2> /dev/null
  sudo -S chsh -s '/usr/local/bin/zsh' "${USER}" <<< "${sudo_password}" 2> /dev/null
}

install_zsh_plugins() {
  readonly local zsh_plugins_dir="${HOME}/.zsh-plugins"
  # oh-my-zsh history
  curl --progress-bar --location 'https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/lib/history.zsh' --output "${zsh_plugins_dir}/oh-my-zsh-history/history.zsh" --create-dirs
  # zsh-completions
  git clone 'git://github.com/zsh-users/zsh-completions.git' "${zsh_plugins_dir}/zsh-completions"
  rm -f "${HOME}/.zcompdump"; compinit # force rebuild zcompdump
  # zsh-syntax-highlighting
  git clone 'git://github.com/zsh-users/zsh-syntax-highlighting.git' "${zsh_plugins_dir}/zsh-syntax-highlighting"
  # zsh-history-substring-search
  git clone 'git://github.com/zsh-users/zsh-history-substring-search.git' "${zsh_plugins_dir}/zsh-history-substring-search"
}


install_vscode_packages() {
  code --install-extension ms-vscode.csharp donjayamanne.python robertohuertasm.vscode-icons cssho.vscode-svgviewer
}

configure_git() {
  echo -e "[user]\n\tname = ${name}\n\temail = ${github_email}\n[github]\n\tuser = ${github_username}" > "${HOME}/.gitconfig"
  git config --global credential.helper osxkeychain
  git config --global push.default simple
  git config --global rerere.enabled true
  git config --global rerere.autoupdate true
}

lower_startup_chime() {
  curl -fsSL 'https://raw.githubusercontent.com/vitorgalvao/lowchime/master/lowchime' --output '/tmp/lowchime'
  chmod +x '/tmp/lowchime'
  sudo -S /tmp/lowchime install <<< "${sudo_password}" 2> /dev/null
}