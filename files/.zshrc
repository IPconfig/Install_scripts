# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/Justin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# load fish-like autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# load aliases
source ~/.aliases


  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship
