local lspsaga = require('lspsaga')

lspsaga.init_lsp_saga {
    finder_action_keys = {
        open = {'<CR>', 'o'}, vsplit = 's',split = 'i',quit = {'q', '<esc>', '<C-c>'},
        scroll_down = '<C-f>',scroll_up = '<C-b>'
    },
    code_action_keys = {
        quit = {'q', '<esc>', '<C-c>'}, exec = '<CR>'
    },
    symbol_in_winbar = {
        in_custom = false,
        enable = true,
        separator = ' ',
        show_file = true,
        click_support = false,
    },
}

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>gh', ':Lspsaga lsp_finder<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rn', ':Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gr', ':Lspsaga lsp_finder<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', 'gpp', ':Lspsaga preview_definition<CR>', opts)

-- ??
vim.api.nvim_set_keymap('n', '<leader>e', ':Lspsaga show_line_diagnostics<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>cc', ':Lspsaga show_cursor_diagnostics<CR>', opts)

