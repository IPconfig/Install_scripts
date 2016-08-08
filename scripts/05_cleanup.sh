cleanup_brew() {
  brew cleanup --force
  rm -rf "$(brew --cache)"
}

cleanup_error_log() {
  sed -i '' '/^Downloading /d;/^-> /d;/^Installing /d;/^Installed /d' "${error_log}" # pyenv downloads
  sed -i '' -E '/#{2,}.*%/d' "${error_log}" # curl progress bars
  sed -i '' '/^Cloning into/d' "${error_log}" # git cloning messages
}

final_message() {
  clear

  echo "All the automated scripts have now finished.
    'stderr' has been logged to '${error_log}'."
}