"if exists("did_load_filetypes")
"    finish
"endif
"augroup filetypedetect
    " Detect Berksfile(s)
    autocmd BufRead,BufNewFile Berksfile set filetype=ruby
    " Detect Vagranntfile(s)
    autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
"augroup END
