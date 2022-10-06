-- Telescope
vim.keymap.set('n', '<leader><leader>', function()
    require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })
end, { silent = true, desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sf', ':Telescope git_files<CR>', { silent = true, desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sc', ':Telescope git_status<CR>', { silent = true, desc = '[S]earch [C]hanged' })
vim.keymap.set('n', '<leader>sg', ':Telescope live_grep<CR>', { silent = true, desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sw', ':Telescope grep_string<CR>', { silent = true, desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s?', ':Telescope oldfiles<CR>', { silent = true, desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>s/', ':Telescope resume<CR>', { silent = true })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostic' })
vim.keymap.set('n', 'z=', require('telescope.builtin').spell_suggest)
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, {desc = '[S]earch [K]eymaps'})
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols, { silent = true, desc = '[S]earch Document [S]ymbols'})
vim.keymap.set('n', '<leader>st', ':TodoTelescope<CR>', { silent = true, desc = '[S]earch [T]ODO marks' })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Next/previous buffer
vim.keymap.set('n', ']b', ':bnext<CR>')
vim.keymap.set('n', '[b', ':bprev<CR>')

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true, desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, { silent = true, desc = '[G]oto type [D]efinition' })
vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { silent = true, desc = '[G]oto [I]mplementations' })
vim.keymap.set('n', "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set('n', "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set('n', "<leader>gr", require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })

