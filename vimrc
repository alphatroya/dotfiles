call plug#begin('~/.vim/plugged')

" A universal set of defaults that (hopefully) everyone can agree on<Paste>
Plug 'sensible.vim'

" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'sleuth.vim'

" Golang support
Plug 'fatih/vim-go', { 'for': 'go' }

" This plugin is used for displaying thin vertical lines at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'

" Swift support
Plug 'keith/swift.vim', { 'for': 'swift' }

" Theme
Plug 'dracula/vim'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Simple tmux statusline generator with support for powerline symbols
Plug 'edkolev/tmuxline.vim'

" A Vim plugin which shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'

" Enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'conradirwin/vim-bracketed-paste'

" Split/join lines plugin
Plug 'AndrewRadev/splitjoin.vim'

" Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
Plug 'terryma/vim-expand-region'

" Easy motions plugin
Plug 'easymotion/vim-easymotion'

" Dash support
Plug 'rizzatti/dash.vim'

" Tagbar
Plug 'majutsushi/tagbar'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Syntax linter
Plug 'w0rp/ale'

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" Autoformat code
Plug 'Chiel92/vim-autoformat'

" Comment stuff out.
Plug 'tpope/vim-commentary'

" Vim repeat
Plug 'tpope/vim-repeat'

" Git wrapper
Plug 'tpope/vim-fugitive'

" ruby support
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" rust support
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Underlines the word under the cursor
Plug 'vim-cursorword'

" A Vim plugin for more pleasant editing on commit messages
Plug 'rhysd/committia.vim'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Inc-/decrement the current value (bool, int, numeric, hex) with one keystroke
Plug 'vim-scripts/nextval'

" Vim code break game
Plug 'johngrib/vim-game-code-break'

" Ack plugin
Plug 'mileszs/ack.vim'

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" format plugin
Plug 'sbdchd/neoformat'

" Make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" rust support customization
let g:rustfmt_autosave = 1

" vim multiple cursors key
let g:multi_cursor_next_key='<C-g>'

" change supertab completion fill to from top
let g:SuperTabDefaultCompletionType = "<c-n>"

" Map leader to ,
let mapleader=','

" Set update time
set updatetime=100

" Autocomplete
let g:deoplete#enable_at_startup = 1

" Easy motions setup
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap <Leader>s <Plug>(easymotion-overwin-f)

" Highlight %VAR% placeholders with the Todo colour group
function! LoadTemplate()
    " setup vim for highlight %VAR% placeholders
    syn match Todo "%\u\+%" containedIn=ALL
endfunction
" Configure templates
autocmd! BufNewFile Fastfile 0r ~/.vim/templates/Fastfile
autocmd! BufNewFile Appfile 0r ~/.vim/templates/Appfile
autocmd! BufNewFile * call LoadTemplate()

" Snippets support
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#enable_snipmate_compatibility = 1
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

" Airline configuration
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

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
nmap <F8> :TagbarToggle<CR>
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

" Tagbar swift configuration
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_swift = {
  \ 'ctagstype': 'swift',
  \ 'kinds' : [
    \ 'n:Enums',
    \ 't:Typealiases',
    \ 'p:Protocols',
    \ 's:Structs',
    \ 'c:Classes',
    \ 'f:Functions',
    \ 'v:Variables',
    \ 'e:Extensions'
  \ ],
  \ 'sort' : 0
  \ }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" NERDTree setting
map <C-q> :NERDTreeToggle<CR>
" configure closing vim if close all splits except NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

"" Encoding
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
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Bindings for vim-go plugin
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
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
let g:go_snippet_engine = "neosnippet"

set showmatch
set number
set colorcolumn=90
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

autocmd BufNewFile,BufRead *.yaml setlocal smarttab tabstop=2 shiftwidth=2

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
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

set nocompatible

set path+=**
set wildmenu

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '¦'
let g:indentLine_faster = 1

" The fish shell is not very compatible to other shells and unexpectedly
" " breaks things that use 'shell'.
if &shell =~# 'fish$'
    set shell=/bin/bash
endif

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

" Fast saving
nmap <leader>w :w!<cr>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Enable syntax highlighting for ruby-based configuration files
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile,Matchfile set syntax=ruby

" Map buffer switching to F6
map <F6> :bn<CR>
map <F7> :bprevious<CR>

" Enable folding
set foldenable

" Set color scheme
set background=dark
colorscheme dracula

" Enable substitution previews with inccommand
if has("nvim")
    set inccommand=split
endif

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

let g:committia_hooks = {}
function! g:committia_hooks.diff_open(info)
    " Additional settings
    setlocal nospell
endfunction

" Make silver searcher as default searcher by Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" fzf bindings
nmap <Leader>; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

