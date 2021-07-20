require("plugins")

vim.o.termguicolors            = true
vim.g.onedark_terminal_italics = 1
vim.cmd [[colorscheme onedark]] -- Set color scheme

vim.g.mapleader                                      = ' '
vim.o.updatetime                                     = 250       -- Because 4 sec is insane
vim.wo.signcolumn                                    = 'yes'     -- Always show sign column
vim.o.spell                                          = true      -- Enable spell check
vim.o.spelllang                                      = "ru_ru,en_us"
vim.o.autowrite                                      = true      -- Enable auto save before :make command
vim.o.showmatch                                      = true
vim.wo.number                                        = true
vim.wo.relativenumber                                = true
vim.o.scrolloff                                      = 8         -- Scroll page as soon I reaching 8 lines before edge
vim.o.colorcolumn                                    = "90"      -- Show vertical line on 90 symbols width
vim.o.mouse                                          = "a"       -- Automatically enable mouse usage
vim.o.expandtab                                      = true      -- Use spaces instead of tabs.
vim.o.softtabstop                                    = 4         -- Tab key indents by 4 spaces.
vim.o.shiftwidth                                     = 4         -- >> indents by 4 spaces.
vim.o.shiftround                                     = true      -- >> indents to next multiple of 'shiftwidth'.
vim.o.hidden                                         = true      -- Switch between buffers without having to save first.
vim.o.showmode                                       = true      -- Show current mode in command-line.
vim.o.ignorecase                                     = true
vim.o.smartcase                                      = true
vim.o.lazyredraw                                     = true      -- Only redraw when necessary.
vim.o.backup                                         = false     -- Directories for swp files
vim.o.swapfile                                       = false
vim.o.inccommand                                     = 'split'   -- Enable substitution previews with inccommand
vim.o.splitbelow                                     = true      -- Open new windows below the current window.
vim.o.splitright                                     = true      -- Open new windows right of the current window.
vim.o.cursorline                                     = true      -- Find the current line quickly.
vim.o.wrapscan                                       = true      -- Searches wrap around end-of-file.
vim.o.report                                         = 0         -- Always report changed lines.
vim.o.synmaxcol                                      = 200       -- Only highlight the first 200 columns.
vim.o.list                                           = true      -- Show non-printable characters.

vim.cmd [[set display     +=lastline]] -- Show as much as possible of the last line.

vim.o.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

vim.api.nvim_set_keymap('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true, noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true }) --  map <esc> to exit from the nvim terminal

vim.api.nvim_set_keymap('c', 'W!', 'w!', { noremap = true })
vim.api.nvim_set_keymap('c', 'Q!', 'q!', {noremap = true})
vim.api.nvim_set_keymap('c', 'Qall!', 'qall!', {noremap = true})
vim.api.nvim_set_keymap('c', 'Wq', 'wq', {noremap = true})
vim.api.nvim_set_keymap('c', 'Wa', 'wa', {noremap = true})
vim.api.nvim_set_keymap('c', 'wQ', 'wq', {noremap = true})
vim.api.nvim_set_keymap('c', 'WQ', 'wq', {noremap = true})
vim.api.nvim_set_keymap('c', 'W', 'w', {noremap = true})
vim.api.nvim_set_keymap('c', 'Q', 'q', {noremap = true})
vim.api.nvim_set_keymap('c', 'Qall', 'qall', {noremap = true})
vim.api.nvim_set_keymap('c', 'Ц', 'w', {noremap = true})
vim.api.nvim_set_keymap('c', 'ц', 'w', {noremap = true})
vim.api.nvim_set_keymap('c', 'Й', 'q', {noremap = true})
vim.api.nvim_set_keymap('c', 'й', 'q', {noremap = true})
vim.api.nvim_set_keymap('c', 'Цй', 'wq', {noremap = true})
vim.api.nvim_set_keymap('c', 'ЦЙ', 'wq', {noremap = true})
vim.api.nvim_set_keymap('c', 'цй', 'wq', {noremap = true})

vim.api.nvim_exec(
[[
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 " using tab for golang

" Enable syntax highlighting for ruby-based configuration files
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile,Matchfile set syntax=ruby

autocmd FileType swift nmap <leader>t :!swift test<CR>
]], false)

vim.g.committia_hooks = {
    diff_open = function()
        vim.wo.spell = false
    end
}

-- Start interactive EasyAlign in visual mode (e.g. vipga)
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

-- automatically trim whitespaces on save, provided by vim-better-whitespace plugin
vim.g.strip_whitespace_on_save = 1

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {timeout=250, on_visual=true}') -- hightlight yank
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':source %<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<cr>', { noremap = true })

-- call neogit
vim.api.nvim_set_keymap('n', '<leader>git', ':Neogit<cr>', { noremap = true })

vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}

vim.o.completeopt = 'menuone,noselect'

vim.o.pastetoggle = '<F12>'

require('config/lsp')
require('config/compe')
require("config/snippets")
require('config/treesitter')
require('config/gitsigns')
require('config/telescope')
require('spellsitter').setup()

require('neogit').setup {
    integrations = {
        diffview = true
    },
}

require('lualine').setup {
    options = {theme = 'onedark'},
}

