
###################
## Global stuffs ##
###################
#----------------------------------------------------------------------------------------#
# PATH:          the...path...                                                           #
# CLICOLOR:      enable cli colourization                                                #
# EDITOR:        default editor                                                          #
# item2:         to enable iterm2 shell itegration                                       #
# ps1:           custom bash prompt via kirsle.net/wizards/ps1.html                      #
#----------------------------------------------------------------------------------------#

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export CLICOLOR=1
export EDITOR=/usr/bin/nano
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"



#########################
## Bash-git-completion ##
#########################
#------------------------------------------------------------------------------------------------------------#
# GIT_PROMPT_ONLY_IN_REPO:               only display git at ps1 when in a repo                              #
# GIT_PROMPT_FETCH_REMOTE_STATUS=0:      fetch remote status                                                 #
# GIT_PROMPT_SHOW_UPSTREAM=1:            show upstream tracking branch                                       #
# GIT_PROMPT_SHOW_UNTRACKED_FILES=all:   can be no, normal or all; determines counting of untracked files    #
# GIT_PROMPT_START=...    		 		 custom prompt start sequence                                        #
# GIT_PROMPT_END=...                     custom prompt end sequence                                          #
# GIT_PROMPT_THEME=Custom                use custom .git-prompt-colors.sh                                    #
# GIT_PROMPT_THEME=Solarized             use theme                                                           #
#------------------------------------------------------------------------------------------------------------#
GIT_PROMPT_ONLY_IN_REPO=1

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
	GIT_PROMPT_THEME=Solarized_Extravagant
	source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi





##############
## Aliases  ##
##############
#------------------------------------------------------------------------------------------------------------#
# udb:           updating locatedb                                                                           #
# vi:            vi filename => vim filename                                                                 #
# htop:          htop via sudo                                                                               #
# showFinder:    show hidden files in finder                                                                 #
# hideFinder:    hide unhidden files in finder                                                               #
# findDS:        finds all system .DS_Store files resursively (requires root)                                #
# noDS:          disables the creation of .DS_Store files                                                    #
# yesDS:         enables the creation of .DS_Store files                                                     #
# byeDS:         deletes all instances of .DS_Store starting at root and working recursively (requires root) #
#------------------------------------------------------------------------------------------------------------#

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
alias udb='sudo /usr/libexec/locate.updatedb'
alias vi='vim'
alias htop='sudo htop'
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
gpip() {
	PIP_REQUIRE_VIRTUALENV="" pip "$@"
}