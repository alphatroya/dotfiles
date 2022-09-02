local keymap = vim.keymap.set

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

keymap("n", "<leader>gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "gpp", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

-- Only jump to error
keymap("n", "[e", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
keymap("n", "]e", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
