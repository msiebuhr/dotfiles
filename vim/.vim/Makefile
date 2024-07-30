autoload/pathogen.vim:
	mkdir -p autoload bundle
	curl 'www.vim.org/scripts/download_script.php?src_id=16224' > autoload/pathogen.vim

pack/vim-autoformat:
	mkdir -p pack/vim-autoformat
	git clone --depth=1 --branch=master https://github.com/Chiel92/vim-autoformat.git pack/vim-autoformat/
	rm -rf pack/vim-autoformat/.git

bundle/editorconfig-vim:
	mkdir -p $@
	curl --location https://github.com/editorconfig/editorconfig-vim/archive/refs/tags/v1.2.0.tar.gz |\
		tar --directory $@ --extract --gzip

# Installation and updating commands.
install: autoload/pathogen.vim
