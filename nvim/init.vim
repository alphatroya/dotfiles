call plug#begin('~/.vim/plugged')

" A universal set of defaults that (hopefully) everyone can agree on
Plug 'vim-scripts/sensible.vim'

" LSP config
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-compe'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Theme
Plug 'joshdick/onedark.vim', { 'branch': 'main' }

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
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ray-x/go.nvim'

" Exchange text regions
Plug 'tommcdo/vim-exchange'

" Additional next/previous mapping
Plug 'tpope/vim-unimpaired'

" Show mark symbols on the gutter
Plug 'kshenoy/vim-signature'

" Consistency with ideavim
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/argtextobj.vim'

" Telescope dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Spell checker based on treesitter plugin
Plug 'lewis6991/spellsitter.nvim'

call plug#end()

set termguicolors
colorscheme onedark " Set color scheme

let mapleader=" "

" Airline configuration
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" Because 4 sec is insane
set updatetime=50

" Enable spell check
set spell
set spelllang=ru_ru,en_us

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
set display     +=lastline " Show as much as possible of the last line.
set showmode               " Show current mode in command-line.
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

set inccommand=split " Enable substitution previews with inccommand

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 " using tab for golang

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

" hightlight yank
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=true}

" automatically trim whitespaces on save, provided by vim-better-whitespace
" plugin
let g:strip_whitespace_on_save = 1

lua << EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

local servers = { "gopls", "sourcekit", "vimls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end
EOF

set completeopt=menuone,noselect

lua <<EOF
require('go').setup({
    goimport='gopls',
    gofmt = 'gopls',
})
require('spellsitter').setup()
require('config-compe')
require('treesitter')
EOF

" Call goformat during saving
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
