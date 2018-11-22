set_default_apps() {
  # general extensions
  for ext in {aac,avi,flac,m4a,m4b,mkv,mov,mp3,mp4,mpeg,mpg,wav}; do duti -s com.colliderli.iina "${ext}" all; done # media
  for ext in {css,html,js,json,md,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}


hushlogin(){
  # Silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 
}

install_vscode_packages() {
  code --install-extension ms-python.python vans.haskero robertohuertasm.vscode-icons
}

configure_git() {
  git config --global user.name "${name}"
  git config --global user.email "${github_email}"
  git config --global github.user "${github_username}"
  git config --global credential.helper osxkeychain
  git config --global push.default simple
  git config --global rerere.enabled true
  git config --global rerere.autoupdate true
}

lower_startup_chime() {
  chmod +x '/tmp/install_scripts-master/lowchime'
  sudo --stdin /tmp/install_scripts-master/lowchime install <<< "${sudo_password}" 2> /dev/null
}