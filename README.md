# devconfig

backup & restore dev environment

## Setup for freezing and thawing

```bash
export DEVCONFIG_ROOT=~/devconfig
git clone https://github.com/zachwaite/devconfig "$DEVCONFIG_ROOT"
echo "export DEVCONFIG_ROOT=$DEVCONFIG_ROOT" >> ~/.bashrc
echo 'export PATH="$PATH:$DEVCONFIG_ROOT"' >> ~/.bashrc
source ~/.bashrc
```

## Bootstrapping a dev machine over ssh

The `provision-neovim` script will set you up a dev environment for python,
javascript, and rust development with neovim. It provides:

- neovim (apt, not source install for speed)
- vim plugins from frozen vimrc, including coc.nvim
- nvm
- pyenv
- rust toolchain

Get on the machine as your dev user, then:

```bash
rm -rf /tmp/devconfig
git clone https://github.com/zachwaite/devconfig /tmp/devconfig
DEVCONFIG_ROOT=/tmp/devconfig /tmp/devconfig/bin/provision-neovim
```

You might need to do this if your devuser is not zach:

```bash
sed -i 's/zach/devuser/g' /home/devuser/.vimrc
sed -i 's/zach/devuser/g' /home/devuser/.bashrc
```

## Bootstrapping a dev machine using vagrant

Add this to the Vagrantfile

```
config.vm.provision "shell", inline: "rm -rf /tmp/devconfig", privileged: false
config.vm.provision "shell", inline: "git clone https://github.com/zachwaite/devconfig /tmp/devconfig", privileged: false
config.vm.provision "shell", inline: "DEVCONFIG_ROOT=/tmp/devconfig /tmp/devconfig/bin/provision-neovim", privileged: false
config.vm.provision "shell", inline: "sed -i 's/zach/vagrant/g' /home/vagrant/.vimrc", privileged: false, run: "always"
config.vm.provision "shell", inline: "sed -i 's/zach/vagrant/g' /home/vagrant/.bashrc", privileged: false, run: "always"
```
