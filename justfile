default:
    just --list

install:
    stow --verbose --target=$HOME git vim zsh profile ssh
    stow --verbose --target=$HOME/.config dot-config
    stow --verbose --target=$HOME/.oh-my-zsh/custom oh-my-zsh-custom
