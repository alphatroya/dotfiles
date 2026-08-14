-- Tree-sitter support via the native plugin manager (vim.pack, Neovim 0.12+).
-- The rewritten nvim-treesitter only installs parsers and queries;
-- highlighting and folding themselves are provided by core Neovim.
-- Requires: tree-sitter-cli (>= 0.26.1), a C compiler, curl and tar in $PATH.

local augroup = vim.api.nvim_create_augroup("treesitter", { clear = true })

-- Why VimEnter and not plain init.lua: lazy.nvim (the main plugin manager in
-- this config) sets 'loadplugins' = false and sources plugins itself. When
-- vim.pack.add() is called during init.lua, sourcing of the plugin's
-- plugin/*.lua scripts (which define :TSInstall/:TSUpdate) is deferred to
-- the loadplugins phase — which then never runs. After startup, at VimEnter,
-- vim.pack.add() sources plugin scripts immediately.
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			{
				src = "https://github.com/nvim-treesitter/nvim-treesitter",
			},
		})

		-- Install parsers asynchronously (a no-op if they are already installed).
		-- Add more languages later with `:TSInstall <lang>`.
		require("nvim-treesitter").install({
			"bash",
			"go",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"query",
			"swift",
			"toml",
			"typst",
			"vim",
			"vimdoc",
			"yaml",
		})
	end,
})

-- Syntax highlighting (built into Neovim; needs a parser for the filetype).
-- Parsers and queries live in stdpath("data")/site, which is on the default
-- 'runtimepath', so this works even before the plugin is loaded above.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
