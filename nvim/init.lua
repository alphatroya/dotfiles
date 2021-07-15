vim.api.nvim_exec(
[[
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
Plug 'buoto/gotests-vim' " Support for gotests tool

" Exchange text regions
Plug 'tommcdo/vim-exchange'

" Additional next/previous mapping
Plug 'tpope/vim-unimpaired'

" Show mark symbols on the gutter
Plug 'kshenoy/vim-signature'

" Replace with register (a gr* key bindings)
Plug 'vim-scripts/ReplaceWithRegister'

" Telescope dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Telescope
Plug 'nvim-telescope/telescope.nvim'

" Spell checker based on treesitter plugin
Plug 'lewis6991/spellsitter.nvim'

" A super powerful autopairs for Neovim. It support multiple character.
Plug 'windwp/nvim-autopairs'

" Indent line plugin
Plug 'lukas-reineke/indent-blankline.nvim'

" Super fast git decorations implemented purely in lua/teal.
Plug 'lewis6991/gitsigns.nvim'

" A simple, easy-to-use Vim alignment plugin.
Plug 'junegunn/vim-easy-align'

call plug#end()
]], false)

vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 1
vim.cmd [[colorscheme onedark]] -- Set color scheme

vim.g.mapleader = ' '

-- Airline configuration
vim.g.airline_theme = 'onedark'
vim.g.airline_powerline_fonts = 1

vim.o.updatetime = 50 -- Because 4 sec is insane

vim.o.spell           = true    -- Enable spell check
vim.o.spelllang       = "ru_ru,en_us"
vim.o.autowrite       = true    -- Enable auto save before :make command
vim.o.showmatch       = true
vim.wo.number         = true
vim.wo.relativenumber = true
vim.o.scrolloff       = 8       -- Scroll page as soon I reaching 8 lines before edge
vim.o.colorcolumn     = "90"    -- Show vertical line on 90 symbols width
vim.o.mouse           = "a"     -- Automatically enable mouse usage
vim.o.expandtab       = true    -- Use spaces instead of tabs.
vim.o.softtabstop     = 4       -- Tab key indents by 4 spaces.
vim.o.shiftwidth      = 4       -- >> indents by 4 spaces.
vim.o.shiftround      = true    -- >> indents to next multiple of 'shiftwidth'.
vim.o.hidden          = true    -- Switch between buffers without having to save first.
vim.o.showmode        = true    -- Show current mode in command-line.
vim.o.ignorecase      = true
vim.o.smartcase       = true
vim.o.lazyredraw      = true    -- Only redraw when necessary.
vim.o.backup          = false   -- Directories for swp files
vim.o.swapfile        = false
vim.o.inccommand      = 'split' -- Enable substitution previews with inccommand
vim.o.splitbelow      = true    -- Open new windows below the current window.
vim.o.splitright      = true    -- Open new windows right of the current window.
vim.o.cursorline      = true    -- Find the current line quickly.
vim.o.wrapscan        = true    -- Searches wrap around end-of-file.
vim.o.report          = 0       -- Always report changed lines.
vim.o.synmaxcol       = 200     -- Only highlight the first 200 columns.
vim.o.list            = true    -- Show non-printable characters.

vim.cmd [[set display     +=lastline]] -- Show as much as possible of the last line.

vim.o.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.api.nvim_set_keymap('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true, noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true }) --  map <esc> to exit from the nvim terminal

vim.api.nvim_exec(
[[
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

autocmd FileType swift nmap <leader>t :!swift test<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
]], false)

-- automatically trim whitespaces on save, provided by vim-better-whitespace plugin
vim.g.strip_whitespace_on_save = 1

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {timeout=250, on_visual=true}') -- hightlight yank
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':source %<cr>', { noremap = true })

vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}

vim.o.completeopt = 'menuone,noselect'

require('config/lsp')
require('config/compe')
require('config/treesitter')
require('config/gitsigns')
require('config/telescope')
require('spellsitter').setup()

