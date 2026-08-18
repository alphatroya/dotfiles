-- monokai.nvim colorscheme via the native plugin manager (vim.pack, Neovim 0.12+).
--
-- Unlike the treesitter/surround plugins, this is added synchronously (not
-- deferred to VimEnter) because init.lua applies the "monokai_pro" colorscheme
-- immediately after startup. That is safe here: monokai.nvim ships no
-- plugin/*.lua scripts, so lazy.nvim's `loadplugins = false` does not affect
-- it — vim.pack.add() puts colors/ and lua/ on 'runtimepath' right away, and
-- colors/monokai_pro.vim is sourced on demand by :colorscheme.
-- Requires the 'packpath' fix from init.lua to run first.

vim.pack.add({
	"https://github.com/tanvirtin/monokai.nvim",
})
