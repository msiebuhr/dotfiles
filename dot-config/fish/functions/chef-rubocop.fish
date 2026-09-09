function chef-rubocop
    set -l TMP (mktemp -d)
    docker run -it --rm -v (pwd):/builds/ -v "$TMP:/builds/cookbooks" harbor.one.com/standard-images/ci/onecom-kitchen-build:focal-rootless rubocop $argv
    rm -rf "$TMP"
end
