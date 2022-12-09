#! /usr/bin/env bash

set -o errexit
set -o xtrace
set -o nounset


if [ -z ${XDG_CONFIG_HOME+x} ]; then
  echo "XDG_CONFIG_HOME not set. Setting it to ~/.config for this script.";
  XDG_CONFIG_HOME=~/.config
else
  echo "XDG_CONFIG_HOME is set to: $XDG_CONFIG_HOME";
fi;

COC_ROOT=$XDG_CONFIG_HOME/coc
DEVCONFIG_FILES="$DEVCONFIG_ROOT/files"
VIMRC=$HOME/.vimrc
BASHRC=$HOME/.bashrc
OLD_BASHRC=$HOME/.old-bashrc
NVIM_CONFIG_ROOT=$XDG_CONFIG_HOME/nvim
TMUXCONF=$HOME/.tmux.conf

declare_dir(){
  if [ -d "$1" ]
    then
      echo "$1 already exists. Skipping"
  else
      echo "Creating $1"
      mkdir -p "$1"
  fi
}

freeze_snippets() {
  rm -rf "$DEVCONFIG_FILES/ultisnips"
  cp -r $COC_ROOT/ultisnips/ "$DEVCONFIG_FILES"
}

thaw_snippets() {
  declare_dir "$COC_ROOT"
  declare_dir "$COC_ROOT/extensions"
  cp -r "$DEVCONFIG_FILES/ultisnips" "$COC_ROOT"
}

freeze_vimrc() {
  cp "$VIMRC" "$DEVCONFIG_FILES/vimrc"
}

thaw_vimrc() {
  cp "$DEVCONFIG_FILES/vimrc" "$VIMRC" 
}

freeze_initvimrc() {
  cp "$NVIM_CONFIG_ROOT/init.vim" "$DEVCONFIG_FILES/init.vim"
}

thaw_initvimrc() {
  declare_dir "$NVIM_CONFIG_ROOT"
  cp "$DEVCONFIG_FILES/init.vim" "$NVIM_CONFIG_ROOT/init.vim" 
}

freeze_bashrc() {
  cp "$BASHRC" "$DEVCONFIG_FILES/bashrc"
}

thaw_bashrc() {
  # small chance that this will break bashrc so save backup
  mv "$BASHRC" "$OLD_BASHRC"
  cp "$DEVCONFIG_FILES/bashrc" "$BASHRC" 
}

freeze_tmuxconf() {
  cp "$TMUXCONF" "$DEVCONFIG_FILES/tmux.conf"
}

thaw_tmuxconf() {
  cp "$DEVCONFIG_FILES/tmux.conf" "$TMUXCONF" 
}

