-- Mappings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope git_status<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', ':Telescope grep_string<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f?', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f/', ':Telescope resume<CR>', { noremap = true, silent = true })
