call plug#begin('~/.vim/plugged')

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" A universal set of defaults that (hopefully) everyone can agree on<Paste>
Plug 'vim-scripts/sensible.vim'

" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'vim-scripts/sleuth.vim'

" Golang support
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'jodosha/vim-godebug', { 'for': 'go' }

" This plugin is used for displaying thin vertical lines at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'

" Theme
Plug 'arcticicestudio/nord-vim'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Simple tmux statusline generator with support for powerline symbols
Plug 'edkolev/tmuxline.vim'

" A Vim plugin which shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'

" Enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'conradirwin/vim-bracketed-paste'

" Easy motions plugin
Plug 'easymotion/vim-easymotion'

" Dash support
Plug 'rizzatti/dash.vim'

" Tagbar
Plug 'majutsushi/tagbar'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'for': 'go' }
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'landaire/deoplete-swift', { 'for': 'swift' }

" Syntax linter
Plug 'w0rp/ale'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" Comment stuff out.
Plug 'tpope/vim-commentary'

" Vim repeat
Plug 'tpope/vim-repeat'

" Underlines the word under the cursor
Plug 'vim-scripts/vim-cursorword'

" A Vim plugin for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Inc-/decrement the current value (bool, int, numeric, hex) with one keystroke
Plug 'vim-scripts/nextval'

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" format plugin
Plug 'sbdchd/neoformat'

" Make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Exchange text regions
Plug 'tommcdo/vim-exchange'

" Additional next/previous mapping
Plug 'tpope/vim-unimpaired'

" A dummy text generator
Plug 'vim-scripts/loremipsum'

call plug#end()

" rust support customization
let g:rustfmt_autosave = 1

set termguicolors
let mapleader=" "

" change supertab completion fill to from top
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "context"

" Set update time
set updatetime=100

" Autocomplete
let g:deoplete#enable_at_startup = 1

" Easy motions setup
let g:EasyMotion_smartcase = 1

" Airline configuration
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

nmap <F8> :TagbarToggle<CR>

" Tagbar Rust configuration
autocmd FileType rust :TagbarOpen
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}

" Tagbar go configuration
autocmd FileType go :TagbarOpen
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

syntax on                  " Enable syntax highlighting.

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Enable spell check
set spell
set spelllang=ru_ru,en_us
map <F5> :setlocal spell! spelllang=en_us<CR>

" Enable auto save before :make command
set autowrite

" Keymapping for quickfix navigation
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Bindings for vim-go plugin
autocmd FileType go nmap <C-d>  <Plug>(go-run)
autocmd FileType go nmap <C-t> <Plug>(go-test)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <C-b> :<C-u>call <SID>build_go_files()<CR>

" Bindings for vim-go plugin
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

set showmatch
set number
set colorcolumn=90
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 shiftwidth=2

set hidden                 " Switch between buffers without having to save first.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set hlsearch               " Keep matches highlighted.
set ignorecase
set smartcase

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

"" Directories for swp files
set nobackup
set noswapfile

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
    let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
    let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '¦'
let g:indentLine_faster = 1

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev Ц w
cnoreabbrev ц w
cnoreabbrev Й q
cnoreabbrev й q
cnoreabbrev Цй wq
cnoreabbrev ЦЙ wq
cnoreabbrev цй wq

" Enable syntax highlighting for ruby-based configuration files
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile,Matchfile set syntax=ruby

" Enable folding
set foldenable

" Set color scheme
set background=dark
colorscheme nord

" Enable substitution previews with inccommand
set inccommand=split

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let g:committia_hooks = {}
function! g:committia_hooks.diff_open(info)
    " Additional settings
    setlocal nospell
endfunction

" fzf bindings
nmap <Leader>f :Files<CR>
nmap <Leader>F :GFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>s :Filetypes<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>/ :History/<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Fast saving
nmap <Leader>w :w!<cr>

let g:vim_markdown_conceal = 0
