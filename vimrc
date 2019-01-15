call plug#begin('~/.vim/plugged')

" A universal set of defaults that (hopefully) everyone can agree on<Paste>
Plug 'vim-scripts/sensible.vim'

" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'vim-scripts/sleuth.vim'

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

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }

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

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" Rust support
Plug 'rust-lang/rust.vim'

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
let g:SuperTabDefaultCompletionType = "context"

" Set update time
set updatetime=100

" Autocomplete
let g:deoplete#enable_at_startup = 1

" Airline configuration
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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

let g:LanguageClient_serverCommands = {
\ 'rust': ['rustup', 'run', 'stable', 'rls'],
\ 'swift': ['sourcekit-lsp'],
\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
