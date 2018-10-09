# Set editor
export EDITOR=vim
export VISUAL=$EDITOR

# Set terminal title
# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
case $TERM in
	xterm*)
		precmd () {print -Pn "\e]0;%n@%m: %~\a"}
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

# Completion for various user-supplied things with Homebrew
fpath=(/usr/local/share/zsh/site-completions $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall
zstyle ':completion:*' special-dirs true

# A simple prompt
# See MAN zshmisc
PROMPT='%B%F{white}%2~%f %(!.%F{red}.%F{blue})>%f%b'

# Nice shortcuts
export GZIP='-9' # Having -v breaks tar(1) -z in some cases. See https://bugs.launchpad.net/ubuntu/+source/tar/+bug/883026
export GARMIN_SAVE_RUNS=$HOME/Documents/Sync/GPS/
export GREP_OPTIONS='--color'
export LESS='-FRX' # Git gives it -FRXS, but S means it doesn't break lines (which I quite like).
export MINICOM="-m -c on"

# Aliases
alias ll='ls -l'
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n"


# Mac OS X
if [[ $(uname) == Darwin ]];then
	# ls -color -> ls -G
	alias ls='ls -G -h'

	# Colors on Mac CLI tools
	export CLICOLORS=1

	# Processor count
	PROCESSORS=`sysctl -n hw.ncpu`
fi

if [[ $(uname) == Linux ]];then
	alias ls='ls --color -h'
	PROCESSORS=`grep -c 'model name' /proc/cpuinfo`
fi

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

# Set up my various NPM-repositories
# FIXME: Complains on every shell-start if nothing matches `~/.npmrc-*`.
#foreach npmname (`ls -a ~/ | awk -F npmrc '/^.npmrc-/ {if ($2) {print $2}}'`);
#	alias npm$npmname="npm --userconfig=$HOME/.npmrc$npmname"
#end

if [[ -f ~/.zsh_secrets ]]; then
    .  ~/.zsh_secrets
fi

#if [[ -f ~/.nix-profile/etc/profile.d/nix.sh ]]; then
#    . ~/.nix-profile/etc/profile.d/nix.sh
#fi

# GVim on Ubuntu 11.10 doesn't work OK. Install from this PPA, to make shit work:
# https://launchpad.net/~yofel/+archive/backports
# (And see https://bugs.launchpad.net/ubuntu/+source/vim/+bug/776499 for details.)
