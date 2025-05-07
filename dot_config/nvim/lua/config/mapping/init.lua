vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer", noremap = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { desc = "Previous buffer", noremap = true })

vim.keymap.set("n", "gv", "`[v`]", { desc = "Reselect pasted text", noremap = true })

-- Copy/paste from clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { silent = true, desc = "[G]oto type [D]efinition" })
