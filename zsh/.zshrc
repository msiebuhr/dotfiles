# Set terminal title
# http://www.faqs.org/docs/Linux-mini/Xterm-Title.html
case $TERM in
	xterm*)
        precmd () { print -Pn "\e]0;%2d\a" }
        ;;
esac

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# Ingore duplicate entries in history
setopt HIST_IGNORE_DUPS

# Set some keys on Mac keyboards (using iTerm to xterm defaults)
#bindkey "^[[H" beginning-of-line # Home
#bindkey "^[[F" end-of-line # End
#bindkey "^A" beginning-of-line
#bindkey "^E" end-of-line
#bindkey "^[[3~" delete-char # delete
#bindkey "^[[1;9D" backward-word # alt + left arrow
#bindkey "^[[1;9C" forward-word # alt + right arrow
bindkey "^N" history-incremental-search-forward
bindkey "^R" history-incremental-search-backward

# Get hold of by paths
foreach extrapath (
    #~/bin
    $HOME/.local/bin
    $HOME/Source/go/bin
    $HOME/.cargo/bin
    /usr/local/share/npm/bin
    /bin
    /sbin
    /usr/bin
    /usr/sbin
    /usr/local/bin
    /usr/local/go/bin
    /usr/local/opt/go/libexec/bin
    #/usr/lib/go-1.17/bin
    # Krew installed? (https://krew.sigs.k8s.io/)
    #$HOME/.krew/bin
    );
	if [[ -d $extrapath ]]; then
		export PATH=$extrapath:$PATH
	fi
end

# If `bazelisk` is installed, use it as `bazel`
if type bazelisk &> /dev/null; then
    alias bazel=bazelisk
    compdef bazelisk=bazel
fi

# Initialize homebrew completions
# See https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
    BREW_PREFIX=$(brew --prefix)
    FPATH=${BREW_PREFIX}/share/zsh-completions:$FPATH
    # FPATH=${BREW_PREFIX}/share/zsh/site-functions:$FPATH
    # FPATH=${BREW_PREFIX}/share/zsh/site-completions:$FPATH
fi

# More places to look for completions
foreach extrafpath (
    # https://github.com/zsh-users/zsh-completions
    /usr/share/zsh/site-functions

    # https://fossies.org/linux/git/contrib/completion/git-completion.zsh
    ~/.zsh/completion
    );
    if [[ -d $extrafpath ]]; then
        fpath[1,0]=$extrafpath
        #FPATH=$extrafpath:$FPATH
    fi
end

# Try new-ish git completion in the end
#zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
zstyle ':completion:*:*:bazel:*' script /usr/share/zsh/site-functions/_bazel
zstyle ':completion:*:*:bazelisk:*' script /usr/share/zsh/site-functions/_bazel

# Cache completion-stuff?
autoload -Uz compinit
compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select

# A simple prompt
# See MAN zshmisc
PROMPT='%B%F{color1}%2~%f %(?.%F{color3}.%F{color2})%#%f%b '

# Set editor
export EDITOR=vim
export VISUAL=$EDITOR

# Set some default arguments
#export GZIP='-9' # Having -v breaks tar(1) -z in some cases. See https://bugs.launchpad.net/ubuntu/+source/tar/+bug/883026
export LESS='-FRX' # Git gives it -FRXS, but S means it doesn't break lines (which I quite like).
export MINICOM="-m -c on"

# Aliases
alias grep='grep --color=auto'
alias ll='ls -l'

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


# GO
export GOBIN="$HOME/.local/bin"
if [[ -d $HOME/Source/go ]]; then
	export GOPATH=$HOME/Source/go
fi

# Optional paths to source
foreach extrasource (
    #~/.zsh/*.zsh

    # Optional local secrets
    ~/.zsh_secrets

    # While I currently run `kubectl` as provided by Docker-for-mac, ZSH
    # completion comes from `brew install kubectl`. As that isn't linked in,
    # I have to grab the completion-file directly from the install:
    # Alternatively: Switch to oh-my-zsh and use their completion
    /usr/local/Cellar/kubernetes-cli/1.14.0/share/zsh/site-functions/_kubectl
    );
    if [[ -f $extrasource ]]; then
        source $extrasource;
    fi
end

function chef-rubocop() {
  mkdir -p ./chef-syntax-empy-dir
  docker run -it --rm -v $(pwd):/builds/ -v $(pwd)/chef-syntax-empy-dir:/builds/cookbooks harbor.one.com/standard-images/ci/onecom-kitchen-build:focal-rootless rubocop $@
  rm -rf ./chef-syntax-empy-dir
}
