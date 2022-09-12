-- Mappings
vim.keymap.set('n', '<leader>ff', ':Telescope git_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fc', ':Telescope git_status<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fr', ':Telescope grep_string<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fl', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f?', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f/', ':Telescope resume<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gr", require('telescope.builtin').lsp_references)
vim.keymap.set('n', 'gg', function()
    require('telescope.builtin').diagnostics({ bufnr = 0 })
end)
vim.keymap.set('n', 'gG', require('telescope.builtin').diagnostics)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
