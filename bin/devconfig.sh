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
INITVIMRC=$XDG_CONFIG_HOME/nvim/init.vim
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
  cp -r "$DEVCONFIG_FILES/ultisnips" "$COC_ROOT"
}

freeze_vimrc() {
  cp "$VIMRC" "$DEVCONFIG_FILES/vimrc"
}

thaw_vimrc() {
  cp "$DEVCONFIG_FILES/vimrc" "$VIMRC" 
}

freeze_initvimrc() {
  cp "$INITVIMRC" "$DEVCONFIG_FILES/init.vim"
}

thaw_initvimrc() {
  cp "$DEVCONFIG_FILES/init.vim" "$INITVIMRC" 
}


freeze_tmuxconf() {
  cp "$TMUXCONF" "$DEVCONFIG_FILES/tmux.conf"
}

thaw_tmuxconf() {
  cp "$DEVCONFIG_FILES/tmux.conf" "$TMUXCONF" 
}

