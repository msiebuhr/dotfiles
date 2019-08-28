
# Set terminal title
# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
case $TERM in
	xterm*)
        precmd () {print -Pn "\e]0;%2d\a"}
        ;;
esac

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# Ingore duplicate entries in history
setopt HIST_IGNORE_DUPS

# Set some keys on Mac keyboards (using iTerm to xterm defaults)
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[F" end-of-line # End
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^[[3~" delete-char # delete
bindkey "^[[1;9D" backward-word # alt + left arrow
bindkey "^[[1;9C" forward-word # alt + right arrow
bindkey "^N" history-incremental-search-forward
bindkey "^R" history-incremental-search-backward


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc

# Initialize homebrew completions
# See https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    FPATH=${BREW_PREFIX}/share/zsh-completions:$FPATH
    FPATH=${BREW_PREFIX}/share/zsh/site-functions:$FPATH
    #FPATH=${BREW_PREFIX}/share/zsh/site-completions:$FPATH
fi


# Cache completion-stuff?
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# End of lines added by compinstall
zstyle ':completion:*' special-dirs true

# A simple prompt
# See MAN zshmisc
PROMPT='%B%F{white}%2~%f %(!.%F{red}.%F{blue})>%f%b'

# Set editor
export EDITOR=vim
export VISUAL=$EDITOR

# Set some default arguments
export GZIP='-9' # Having -v breaks tar(1) -z in some cases. See https://bugs.launchpad.net/ubuntu/+source/tar/+bug/883026
export GARMIN_SAVE_RUNS=$HOME/Documents/Sync/GPS/
export GREP_OPTIONS='--color'
export LESS='-FRX' # Git gives it -FRXS, but S means it doesn't break lines (which I quite like).
export MINICOM="-m -c on"

# Aliases
alias ll='ls -l'
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n"

# Locale
# https://stackoverflow.com/questions/56716993/error-message-when-starting-vim-failed-to-set-locale-category-lc-numeric-to-en
export LC_ALL=en_US.UTF-8
export LC_MONETARY=da_DK.UTF-8

# Mac OS X
if [[ $(uname) == Darwin ]];then
	# ls -color -> ls -G
	alias ls='ls -G -h'

	# Colors on Mac CLI tools
	export CLICOLORS=1
fi

if [[ $(uname) == Linux ]];then
	alias ls='ls --color -h'
fi

# Processor count
PROCESSORS=$(nproc)

# Set build parallelism based on processor count
export MAKEFLAGS="-j $PROCESSORS"
export SCONSFLAGS="-j $PROCESSORS"

# Get hold of by paths
foreach extrapath (
    #~/bin
    ~/.local/bin
    /usr/local/share/npm/bin
    $HOME/Source/go/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    /usr/local/bin
    /usr/local/opt/go/libexec/bin
    );
	if [[ -d $extrapath ]]; then
		export PATH=$extrapath:$PATH
	fi
end

# GO
if [[ -d $HOME/Source/go ]]; then
	export GOPATH=$HOME/Source/go
fi

# Optional paths to source
foreach extrasource (
    # From `brew cask install google-cloud-sdk
    /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

    # Optional local secrets
    ~/.zsh_secrets

    # While I currently run `kubectl` as provided by Docker-for-mac, ZSH
    # completion comes from `brew install kubectl`. As that isn't linked in,
    # I have to grab the completion-file directly from the install:
    # Alternatively: Switch to oh-my-zsh and use their completion
    /usr/local/Cellar/kubernetes-cli/1.14.0/share/zsh/site-functions/_kubectl

    # Play with NIX
    # ~/.nix-profile/etc/profile.d/nix.sh
    );
    if [[ -f $extrasource ]]; then
        source $extrasource;
    fi
end

# Set up my various NPM-repositories
# FIXME: Complains on every shell-start if nothing matches `~/.npmrc-*`.
#foreach npmname (`ls -a ~/ | awk -F npmrc '/^.npmrc-/ {if ($2) {print $2}}'`);
#	alias npm$npmname="npm --userconfig=$HOME/.npmrc$npmname"
#end
