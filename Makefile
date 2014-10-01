_gitignore_global:
	echo '# https://raw.githubusercontent.com/github/gitignore/master/Global/OSX.gitignore' > $@
	curl https://raw.githubusercontent.com/github/gitignore/master/Global/OSX.gitignore >> $@
	echo >> $@
	echo '# https://raw.githubusercontent.com/github/gitignore/master/Global/vim.gitignore' >> $@
	curl https://raw.githubusercontent.com/github/gitignore/master/Global/vim.gitignore >> $@
