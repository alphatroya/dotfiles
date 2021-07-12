call plug#begin('~/.vim/plugged')

" A universal set of defaults that (hopefully) everyone can agree on
Plug 'vim-scripts/sensible.vim'

" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'vim-scripts/sleuth.vim'

" Theme
Plug 'arcticicestudio/nord-vim'

" Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" A Vim plugin which shows a git diff in the 'gutter'
Plug 'airblade/vim-gitgutter'

" Enables transparent pasting into vim. (i.e. no more :set paste!)
Plug 'conradirwin/vim-bracketed-paste'

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
"
" Golang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'majutsushi/tagbar'

" A collection of language packs for Vim.
Plug 'sheerun/vim-polyglot'

" Make the yanked region apparent
Plug 'machakann/vim-highlightedyank'

" Exchange text regions
Plug 'tommcdo/vim-exchange'

" Additional next/previous mapping
Plug 'tpope/vim-unimpaired'

" Show mark symbols on the gutter
Plug 'kshenoy/vim-signature'

" Consistency with ideavim
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/argtextobj.vim'

" Fades your inactive buffers
Plug 'TaDaa/vimade'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP config
Plug 'neovim/nvim-lspconfig'
call plug#end()

let mapleader=" "

" Airline configuration
let g:airline_theme='nord'
let g:airline_powerline_fonts = 1

" Enable syntax highlighting.
syntax on

" Because 4 sec is insane
set updatetime=50

" Enable spell check
set spell
set spelllang=ru_ru,en_us
set termguicolors

set autowrite " Enable auto save before :make command
set showmatch
set number relativenumber
set scrolloff=8             " Scroll page as soon I reaching 8 lines before edge
set colorcolumn=90          " Show vertical line on 90 symbols width
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set hidden                 " Switch between buffers without having to save first.
set display     =lastline  " Show as much as possible of the last line.
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set hlsearch               " Keep matches highlighted.
set ignorecase
set smartcase
set lazyredraw             " Only redraw when necessary.
set nobackup               " Directories for swp files
set noswapfile
set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.
set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set list                   " Show non-printable characters.

" Set color scheme
set background=dark
colorscheme nord

set inccommand=split " Enable substitution previews with inccommand

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

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

let g:committia_hooks = {}
function! g:committia_hooks.diff_open(info)
    " Additional settings
    setlocal nospell
endfunction

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nmap <Leader>w :w!<cr> " Fast saving

autocmd FileType swift nmap <leader>t :!swift test<CR>

" fzf
nnoremap <silent> <Leader><Enter>   :Files<CR>
nnoremap <silent> <Leader><Leader>  :Buffers<CR>

" automatically trim whitespaces on save, provided by vim-better-whitespace
" plugin
let g:strip_whitespace_on_save = 1

lua << EOF
require'lspconfig'.sourcekit.setup{}
require'lspconfig'.gopls.setup{}
EOF
