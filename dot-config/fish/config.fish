if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # From https://starship.rs/guide/
    starship init fish | source

    # Jujutsu dynamic completions (see https://docs.jj-vcs.dev/latest/install-and-setup/#dynamic_2)
    # OBSOLETE after fish 4.0.2
    COMPLETE=fish jj | source

    # Make <ctrl>+<backspace> delete words
    # See https://www.reddit.com/r/fishshell/comments/uqv70m/comment/ivuzdxq/
    #bind \cH backward-kill-word
end

set -gx GOPROXY https://goproxy.groupone.dev,https://proxy.golang.org,direct
set -gx EDITOR vim
