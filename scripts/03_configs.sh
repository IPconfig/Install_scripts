set_default_apps() {
  # general extensions
  for ext in {css,js,json,md,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}


hushlogin(){
  # Silence the last login time in terminal
  mv /tmp/install_scripts-master/.hushlogin ~/.hushlogin 
}


install_fish_plugins() {
  chmod +x '/tmp/install_scripts-master/configure.fish'
  fish '/tmp/install_scripts-master/configure.fish'
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
  curl -fsSL 'https://raw.githubusercontent.com/vitorgalvao/lowchime/master/lowchime' --output '/tmp/lowchime'
  chmod +x '/tmp/lowchime'
  sudo --stdin /tmp/lowchime install <<< "${sudo_password}" 2> /dev/null
}