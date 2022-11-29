# devconfig

backup & restore dev environment

## Setup

```sh
export DEVCONFIG_ROOT=~/devconfig
git clone https://github.com/zachwaite/devconfig "$DEVCONFIG_ROOT"
echo "export DEVCONFIG_ROOT=$DEVCONFIG_ROOT" >> ~/.bashrc
echo 'export PATH="$PATH:$DEVCONFIG_ROOT"' >> ~/.bashrc
source ~/.bashrc
```
