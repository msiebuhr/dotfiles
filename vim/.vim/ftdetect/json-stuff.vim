"if exists("did_load_filetypes")
"    finish
"endif
"augroup filetypedetect
    " Map JSON-files to use JavaScript syntax
    autocmd BufNewfile,BufEnter,BufRead *.json set ft=javascript
    autocmd BufNewfile,BufEnter,BufRead *.cjson set ft=javascript
"augroup END
