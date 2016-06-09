# install_scripts
My personal install scripts used to set up a new OSX installation. These scripts are based on my needs and may be altered for your preferences


### Install everything with this simple command
```
bash -c "$(curl -fsSL 'https://raw.github.com/IPconfig/install_scripts/master/install.sh')"
```

`scripts` is a directory that contains various shell scripts. However, none of them will actually do anything if ran on their own. They consist of nothing more than a lot of structured functions to perform various tasks.

`install.sh` is what brings it all together in an automated fashion. It loads up all the script functions and runs them sequentially.
