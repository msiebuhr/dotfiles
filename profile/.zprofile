# Get hold of by paths
foreach extrapath ($HOME/.local/bin $HOME/.gem/ruby/1.8/bin $HOME/.cargo/bin $HOME/Source/golang/bin /home/linuxbrew/.linuxbrew/bin);
	if [[ -d $extrapath ]]; then
		export PATH=$extrapath:$PATH
	fi
end
