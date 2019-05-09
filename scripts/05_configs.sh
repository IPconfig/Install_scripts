function set_default_apps {
  # general extensions
  for ext in {aac,avi,flac,m4a,m4b,mkv,mov,mp3,mp4,mpeg,mpg,wav}; do duti -s com.colliderli.iina "${ext}" all; done # media
  for ext in {css,html,js,json,md,php,pug,py,rb,sh,txt}; do duti -s com.microsoft.VSCode "${ext}" all; done # code
}

function configure_zsh {
  local recent_zsh='/usr/local/bin/zsh'
  renew_sudo
  log_success 'Making ZSH the default shell.'

  if [[ "${SHELL}" == "${recent_zsh}" ]]; then
    log_error 'ZSH is already the default shell.'

  else 
    sudo sh -c "echo '${recent_zsh}' >> /etc/shells"
    sudo chsh -s "${recent_zsh}" "${USER}"
  fi


  log_info 'Installing ZSH theme'
  npm install -g spaceship-prompt
}

function configure_git {
  local full_name github_email github_username github_password github_token
  ask 'Give details to configure git:'
  read -rp 'First and last name: ' full_name
  read -rp 'GitHub email: ' github_email
  read -rp 'GitHub username: ' github_username
  read -rsp "GitHub password (never stored): " github_password
  echo

  git config --global user.name "${full_name}"
  git config --global github.user "${github_username}"
  git config --global user.email "${github_email}"
  git config --global credential.helper osxkeychain

  ask 'Request a GitHub token for CLI use.'
  local request=(curl --silent 'https://api.github.com/authorizations' --user "${github_username}:${github_password}" --data "{\"scopes\":[\"repo\"],\"note\":\"macOS CLI for ${USER} on $(scutil --get LocalHostName)\"}")

  local response="$("${request[@]}")"

  while grep --quiet 'Must specify two-factor authentication OTP code.' <<< "${response}"; do
    read -rp '2FA code: ' otp
    response="$("${request[@]}" --header "X-GitHub-OTP: ${otp}")"
  done

  if ! grep --quiet '"token"' <<< "${response}"; then
    echo -e "\n${response}" >&2
    return
  fi

  local github_token="$(grep 'token' <<< "${response}" | head -1 | cut -d'"' -f4)"

  log_info 'Storing GitHub token in Keychain.'
  git credential-osxkeychain store <<< "$(echo -e "host=github.com\nprotocol=https\nusername=${github_username}\npassword=${github_token}")"

  ask 'Request a GitHub token for `climergebutton`.'
  climergebutton --ensure-token
}

function install_editor_packages {
  code --install-extension ms-python.python vans.haskero robertohuertasm.vscode-icons
}