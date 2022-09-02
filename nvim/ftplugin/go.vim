autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

setlocal tabstop=4 shiftwidth=4 softtabstop=4 " using tab for golang

nmap <leader>t :GoTest<CR>
nmap <leader>a :GoAlt<CR>
nmap <leader>gat :GoAddTag<CR>
nmap <leader>if :GoIfErr<CR>
nmap <leader>c :GoCoverage<CR>
nmap <leader>gfs :GoFillStruct<CR>
