[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Make color constants available.
autoload -U colors && colors

# Enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1
export EDITOR=code
##############
## zplug    ##
##############

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh


zplug "zsh-users/zsh-completions"
zplug "plugins/git",   from:oh-my-zsh
zplug "zlsun/solarized-man"
zplug "zsh-users/zsh-autosuggestions", nice:10
zplug "plugins/brew", from:oh-my-zsh, nice:10
zplug "plugins/brew-cask", from:oh-my-zsh, nice:10

# Syntax highlighting bundle. zsh-syntax-highlighting must be loaded after
# excuting compinit command and sourcing other plugins.
zplug "zsh-users/zsh-syntax-highlighting", nice:10
# ZSH port of Fish shell's history search feature
zplug "zsh-users/zsh-history-substring-search", nice:10


# theme
setopt prompt_subst # Make sure prompt is able to be generated properly.
zplug "adambiggs/zsh-theme", use:adambiggs.zsh-theme


# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi
# source plugins and add commands to the PATH
zplug load


# zsh-users/zsh-completions
zmodload zsh/terminfo
[ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down

##############
## Aliases  ##
##############
#------------------------------------------------------------------------------------------------------------#
# showFinder:    show hidden files in finder                                                                 #
# hideFinder:    hide unhidden files in finder                                                               #
# findDS:        finds all system .DS_Store files resursively (requires root)                                #
# noDS:          disables the creation of .DS_Store files                                                    #
# yesDS:         enables the creation of .DS_Store files                                                     #
# byeDS:         deletes all instances of .DS_Store starting at root and working recursively (requires root) #
#------------------------------------------------------------------------------------------------------------#
alias showFinder='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFinder='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias findDS='sudo find . "-name" ".DS_Store"'
alias noDS='defaults write com.apple.desktopservices DSDontWriteNetworkStores true'
alias yesDS='defaults write com.apple.desktopservices DSDontWriteNetworkStores false'
alias byeDS='sudo find . "-name" ".DS_Store" -exec rm {} \;'

##################
## Python Stuff ##
##################
#------------------------------------------------------------#
# WORKON_HOME:             virtualenvs reside                #
# PROJECT_HOME:            python projects reside            #
# VIRTUALWRAPPER_PYTHON:   brew python binary for venvs      #
# PIP_REQUIRE_VIRTUALENV:  forces active venv to use pip     #
#------------------------------------------------------------#
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/projects
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
source /usr/local/bin/virtualenvwrapper.sh
export PIP_REQUIRE_VIRTUALENV=true



#####################
## Custom functions##
#####################
#--------------------------------------------------------#
# gpip:  allow for global pip use                        #
#--------------------------------------------------------#
gpip() { PIP_REQUIRE_VIRTUALENV="" pip "$@" }


#####################
## Other Stuff     ##
#####################

# Improve terminal title
case "${TERM}" in
    kterm*|xterm*|vt100)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

# Share zsh histories
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=50000
setopt inc_append_history
setopt share_history

##################
## Completion ##
##################
# Load and initialize the completion system ignoring insecure directories.
autoload -Uz compinit && compinit -i

unsetopt FLOWCONTROL
unsetopt MENU_COMPLETE

setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt EXTENDEDGLOB

zmodload -i zsh/complist

# case-insensitive (all), partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
       'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Use GNU ls color specification
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Autocompletion with an arrow-key driven interface
zstyle ':completion:*:*:*:*:*' menu select

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*:paths' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
  man postgres shutdown '_*'

zstyle '*' single-ignored complete