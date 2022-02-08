local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gI', [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]], opts)
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
    buf_set_keymap('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

    local cfg = {
        use_lspsaga = true,  -- set to true if you want to use lspsaga popup
        hi_parameter = "IncSearch", -- how your parameter will be highlight
    }
    require "lsp_signature".on_attach(cfg, bufnr)
    require 'illuminate'.on_attach(client)
end

local servers = { "gopls", "sourcekit", "vimls", "jsonls", "yamlls" }
for _, lsp in ipairs(servers) do
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- lua LSP configuration
-- works only if lua-language-server cloned and compiled in the home directory
-- more info: https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand("~/lua-language-server")
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
