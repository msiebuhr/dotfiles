" Set up pathogen
call pathogen#infect()

"I want syntax highligthing
if has("syntax")
	syntax on
endif

" Add Ubnutus addon-path
"set runtimepath+=/usr/share/vim/addons/

" Skal buges at vim-LaTeX
filetype plugin on
filetype indent on

"S�tter lidt specielle ting hvis der k�res p� windows
if has('win32')
    " vim-LaTeX-specifikt.
    set shellslash
    set grepprg=grep\ -nH\ $*
endif

" Bedre fonte
if has("gui_running")
    " zenburn on GUI
    colorscheme zenburn
    if has("gui_gtk2")
        "set guifont=Inconsolata\ 12
        set guifont=SourceCodePro\ 13
    elseif has("gui_macvim")
        set vb " No audible bell
        " Enabling this makes ex. {} turn into copyright and � on DK kbd...
        "set macmeta " Allow use of Option as meta key
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Lucida_Console:h11:cANSI
    endif
else
    " Default colors elsewhere
    colorscheme default
endif

" Editor layout
set nu					" Linje-numerering
set showmatch			" Parenthesis matching
set ruler				" I want to see where I am in the file

"Intet toolbar-pjat
set guioptions-=T
if ! has('win32') " Kun menu-bar i windows
	set guioptions+=mrL
end
set guioptions+=ac


" Editor behaviour
set backspace=2			" So that backspace should behave normal
set incsearch			" incremental search
set hlsearch			" Highlight my search
set whichwrap+=<,>,[,]	" backspace and cursor keys wrap to previous/next line
"set foldmethod=marker	" Correct folding is a bliss ...
set foldmethod=syntax	" Fold by whatever syntax the syntaxer fancies.


" Code stuff
set autoindent		" autoindention
set shiftwidth=4	" My tabs are 4 chars.
set tabstop=4
set expandtab       " Expand all tabs to spaces
set nofixendofline  " Doesn't add trail EOL if file doesn't have one

set nocp			" No VI for me ....

" Make CTRL-P ignore node_modules, .git and other junk
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](node_modules|.git|.svn)$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|node_modules|coverage)$', }

" Hvis jeg bruger JAVA skal den bruge c-style indentering
autocmd BufNewfile,BufEnter,BufLeave *.java set cindent
set complete=.,w,b,u,t,i,d,k

" Suffixes to ignore in file completion
set suffixes=.bak,.swp,.o,~,.class,.exe,.obj,.dvi,.pdf,.aux

"Husk hvor jeg er i filerne (brug .viminfo)
augroup JumpCursorOnEdit
au!
autocmd BufReadPost *
	\ if expand("<afile>:p:h") !=? $TEMP |
	\   if line("'\"") > 1 && line("'\"") <= line("$") |
	\     let JumpCursorOnEdit_foo = line("'\"") |
	\     let b:doopenfold = 1 |
	\     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
	\        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
	\        let b:doopenfold = 2 |
	\     endif |
	\     exe JumpCursorOnEdit_foo |
	\   endif |
	\ endif
" Need to postpone using "zv" until after reading the modelines.
autocmd BufWinEnter *
	\ if exists("b:doopenfold") |
	\   exe "normal zv" |
	\   if(b:doopenfold > 1) |
	\       exe  "+".1 |
	\   endif |
	\   unlet b:doopenfold |
	\ endif
augroup END

" For misc. applications.
autocmd BufNewfile,BufRead *tex set tw=72

" When I write email in mutt...
autocmd BufNewfile,BufRead /tmp/mutt* set list listchars=tab:>-,trail:. tw=70

"autocmd BufNewfile,BufRead *.go set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
autocmd BufNewfile,BufRead *.go set softtabstop=4 noexpandtab

" JavaScript folding, per http://amix.dk/blog/post/19132
"function! JavaScriptFold()
"	setl foldmethod=syntax
"	setl foldlevelstart=1
"	syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
"
"	function! FoldText()
"		return substitute(getline(v:foldstart), '{.*', '{' . (1 + v:foldend - v:foldstart) . ' lines}', '')
"	endfunction
"	setl foldtext=FoldText()
"endfunction
"au FileType javascript call JavaScriptFold()
"au FileType javascript setl fen