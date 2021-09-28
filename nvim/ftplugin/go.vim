setlocal tabstop=4 shiftwidth=4 softtabstop=4 " using tab for golang

nmap <leader>t  <Plug>(go-test)
nmap <leader>a :GoAlternate!<CR>
nmap <leader>l :GoMetaLinter ./...<CR>
nmap <leader>c <Plug>(go-coverage-toggle)
nmap <leader>if :GoIfErr<CR>
nmap <leader>gat :GoAddTags<CR>
nmap <leader>gfs :GoFillStruct<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
endfunction

nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

let g:go_list_type = "quickfix"
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gopls"
let g:go_rename_command = "gopls"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fillstruct_mode = 'gopls'
let g:go_addtags_transform = "camelcase"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_doc_keywordprg_enabled = 1

let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_enabled = []
