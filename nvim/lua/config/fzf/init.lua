-- Mappings
vim.api.nvim_set_keymap('n', '<leader>ff', [[:GFiles<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[:Rg!<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[:Buffers<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl', [[:Lines<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f?', [[:History<CR>]], { noremap = true, silent = true })
