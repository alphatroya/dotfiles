-- fff (file finder) via the native plugin manager (vim.pack, Neovim 0.12+).
--
-- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim
-- before, clean with `:packdel fff.nvim`.
--
-- Required from init.lua inside a VimEnter autocmd: lazy.nvim sets
-- 'loadplugins' = false, so plugin scripts are only sourced when vim.pack
-- runs after startup (same trick as the treesitter plugin).

-- Schedule the package for cloning / resolution.
vim.pack.add({
	"https://github.com/dmtrKovalenko/fff",
})

-- Build step: download prebuilt binary or compile from source. Fires when
-- vim.pack installs or updates the package (PackChanged).
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "fff" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("fff") -- source plugin/*.lua (registers :FFF* commands)
			end
			require("fff.download").download_or_build_binary()
		end
	end,
})

vim.g.fff = {
	lazy_sync = true,
	debug = {
		enabled = true,
		show_scores = true,
	},
}

-- Keymaps (lazy: fff is only required when the key is pressed).
vim.keymap.set("n", "ff", function()
	require("fff").find_files()
end, { desc = "FFFind files" })

vim.keymap.set("n", "fg", function()
	require("fff").live_grep()
end, { desc = "LiFFFe grep" })

vim.keymap.set("n", "fz", function()
	require("fff").live_grep({
		grep = {
			modes = { "fuzzy", "plain" },
		},
	})
end, { desc = "Live fffuzy grep" })

vim.keymap.set("n", "fc", function()
	require("fff").live_grep({ query = vim.fn.expand("<cword>") })
end, { desc = "Search current word" })

-- Load the package and make sure the rust backend binary is present.
-- Called from init.lua's VimEnter autocmd.
local M = {}

function M.load()
	-- Source plugin/*.lua (registers :FFF* commands). No-op if already sourced.
	if not pcall(vim.cmd.packadd, "fff") then
		return -- package not cloned yet; the PackChanged handler will take over
	end
	-- PackChanged (install/update) normally downloads the binary, but that
	-- event may have fired before this module was ever loaded. Ensure the
	-- rust backend exists on every startup.
	vim.schedule(function()
		if not pcall(require, "fff.rust") then
			require("fff.download").download_or_build_binary()
		end
	end)
end

return M
