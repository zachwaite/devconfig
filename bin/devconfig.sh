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

freeze_snippets() {
  rm -rf "$DEVCONFIG_FILES/ultisnips"
  cp -r $COC_ROOT/ultisnips/ "$DEVCONFIG_FILES"
}

thaw_snippets() {
  cp -r "$DEVCONFIG_FILES/ultisnips" "$COC_ROOT/ultisnips"
}

freeze_vimrc() {
  cp "$VIMRC" "$DEVCONFIG_FILES/vimrc"
}

thaw_vimrc() {
  cp "$DEVCONFIG_FILES/vimrc" "$VIMRC" 
}

