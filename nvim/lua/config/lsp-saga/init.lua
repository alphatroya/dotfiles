local lspsaga = require('lspsaga')

lspsaga.init_lsp_saga()

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>rn', ':Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-k>', ':Lspsaga signature_help<CR>', opts)

