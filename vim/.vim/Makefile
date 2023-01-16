autoload/pathogen.vim:
	mkdir -p autoload bundle
	curl 'www.vim.org/scripts/download_script.php?src_id=16224' > autoload/pathogen.vim

autoload/vim-todo-lists:
	mkdir -p autoload bundle
	git clone --depth=1 --branch=master https://github.com/aserebryakov/vim-todo-lists.git autoload/vim-todo-list
	rm -rf autoload/vim-todo-list/.git

pack/vim-autoformat:
	mkdir -p pack/vim-autoformat
	git clone --depth=1 --branch=master https://github.com/Chiel92/vim-autoformat.git pack/vim-autoformat/
	rm -rf pack/vim-autoformat/.git

# Installation and updating commands.
install: autoload/pathogen.vim autoload/vim-todo-lists
