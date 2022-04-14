require("plugins")

vim.cmd [[colorscheme dracula]] -- Set color scheme

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

vim.api.nvim_exec(
[[
" Safe command remapping, see https://stackoverflow.com/questions/3878692/how-to-create-an-alias-for-a-command-in-vim/3879737#3879737
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")' .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Qall","qall")
call SetupCommandAlias('Wq', 'wq')
call SetupCommandAlias('Wa', 'wa')
call SetupCommandAlias('wQ', 'wq')
call SetupCommandAlias('WQ', 'wq')
call SetupCommandAlias('Ц', 'w')
call SetupCommandAlias('ц', 'w')
call SetupCommandAlias('Й', 'q')
call SetupCommandAlias('й', 'q')
call SetupCommandAlias('Цй', 'wq')
call SetupCommandAlias('ЦЙ', 'wq')
call SetupCommandAlias('цй', 'wq')

" Enable syntax highlighting for ruby-based configuration files
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile,Matchfile set syntax=ruby

" Configure skeletons
autocmd BufNewFile *.sh 0r ~/.skeletons/bash.sh

autocmd FileType swift nmap <leader>t :!swift test<CR>

" vim-illuminate setup
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=inverse
    autocmd VimEnter * hi LspReferenceText cterm=inverse
    autocmd VimEnter * hi LspReferenceWrite cterm=inverse
    autocmd VimEnter * hi LspReferenceRead cterm=inverse
augroup END
let g:Illuminate_delay = 1000

let g:markdown_fenced_languages = ['go', 'swift', 'rust', 'json']

let g:fzf_history_dir = '~/.local/share/fzf-history'

" global statusline
set laststatus=3
]], false)

vim.g.committia_hooks = {
    diff_open = function()
        vim.wo.spell = false
    end
}

-- automatically trim whitespaces on save, provided by vim-better-whitespace plugin
vim.g.strip_whitespace_on_save = 1

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {timeout=250, on_visual=true}') -- hightlight yank
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':source %<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', ':e $MYVIMRC<cr>', { noremap = true })

-- close active buffer
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })

-- keep it centered
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true})

vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}

vim.o.completeopt = 'menu,menuone,noselect'

vim.o.pastetoggle = '<F12>'

require('config/lsp')
require('config/cmp')
require('config/treesitter')
require('config/gitsigns')
require('config/fzf')
require('config/lsp-saga')

require('lualine').setup {
    options = {
        theme = 'dracula',
        globalstatus = true,
    },
}


require('specs').setup {
    show_jumps  = true,
    min_jump = 15,
    popup = {
        delay_ms = 0,
        inc_ms = 10,
        blend = 10,
        width = 20,
        winhl = "PMenu",
        fader = require('specs').exp_fader,
        resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}

require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true,
  }
}

vim.api.nvim_exec([[ let g:vsnip_snippet_dir = expand('~/.vsnip') ]], false)
