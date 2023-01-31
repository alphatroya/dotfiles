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
vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
    { silent = true, desc = '[G]oto [I]mplementations' })
vim.keymap.set('n', "K", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

-- Remaps for the refactoring
require("telescope").load_extension("refactoring")

vim.api.nvim_set_keymap(
    "v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap("v", "<leader>re",
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rv",
    [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
    { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]]
    , { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "<leader>ri",
    [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
    { noremap = true, silent = true, expr = false })

-- debug print
vim.api.nvim_set_keymap(
    "n",
    "<leader>rp",
    ":lua require('refactoring').debug.printf({below = false})<CR>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>rv",
    ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>rv",
    ":lua require('refactoring').debug.print_var({})<CR>",
    { noremap = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>rc",
    ":lua require('refactoring').debug.cleanup({})<CR>",
    { noremap = true }
)
