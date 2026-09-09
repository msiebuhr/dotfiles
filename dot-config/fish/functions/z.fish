# Wrapper for the zed-editor; if it is in a jj project directory, it opens that first and _then_ opens the file within the project
function z
    set -l root $(jj root)
    if test $status -eq 0
        zed $root $argv
    else
        zed $argv
    end
end
