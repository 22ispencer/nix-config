#!/usr/bin/env bash

case $OSTYPE in
  darwin*) sudo darwin-rebuild switch;;
        *) sudo nixos-rebuild switch;;
esac

tmux source-file ~/.config/tmux/tmux.conf
