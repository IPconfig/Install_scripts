# Install scripts
My personal install scripts used to set up a new MacOS installation. These scripts are based on my needs and may be altered for your preferences


### Install everything with this simple command
```
bash -c "$(curl -fsSL 'https://raw.github.com/IPconfig/install_scripts/master/install.sh')"
```

`scripts` is a directory that contain shell scripts to be sourced. None will do anything if ran on their own. They consist of structured functions to perform various tasks.

`install.sh` is what brings it all together in an automated fashion. It loads up all the script functions and runs them sequentially.

# Credits
- [Vítor Galvão](https://github.com/vitorgalvao/dotfiles): for the orginal idea
- [Ahmed El Gabri](https://github.com/ahmedelgabri/dotfiles/tree/master/files): cloning / backing up of dotfiles and helper functions for logging
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles): MacOS Settings
- [Kris Cotter](https://github.com/mrcotter/mrcotter_dotfiles): powerline/solarized theme script

