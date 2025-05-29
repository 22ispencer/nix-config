#!/usr/bin/env bash

rebuild_command=""
case $OSTYPE in
  darwin*) rebuild_command="sudo darwin-rebuild switch";;
        *) rebuild_command="sudo nixos-rebuild switch";;
esac

$rebuild_command && tmux source-file ~/.config/tmux/tmux.conf
