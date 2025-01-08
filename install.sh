#!/usr/bin/env bash

set -eux

stow --verbose --target=$HOME git vim zsh profile ssh

stow --verbose --target=$HOME/.config dot-config
