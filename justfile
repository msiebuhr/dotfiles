default:
    just --list

install:
    stow --verbose --target=$HOME git vim zsh profile ssh
    stow --verbose --target=$HOME/.config dot-config
