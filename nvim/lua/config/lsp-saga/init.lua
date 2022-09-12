local lspsaga = require('lspsaga')
lspsaga.init_lsp_saga {
    finder_action_keys = {
        open = {'<CR>', 'o'}, vsplit = 's',split = 'i',quit = {'q', '<esc>', '<C-c>'},
        scroll_down = '<C-f>',scroll_up = '<C-b>'
    },
    rename_in_select = false,
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
    show_outline = {
        win_position = 'right',
        auto_enter = false,
        auto_preview = false,
        jump_key = '<CR>',
        auto_refresh = true,
    },
}

local keymap = vim.keymap.set
-- keymap("n", "<leader>gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })

keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("v", "<leader>ca", "<cmd>Lspsaga range_code_action<CR>", { silent = true })

keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

