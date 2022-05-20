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
    buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
    buf_set_keymap('n', '<leader>l', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>ft', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

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
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        },
        flags = {
            debounce_text_changes = 150,
        }
    }
end

require('lint').linters_by_ft = {
  go = {'golangcilint',}
}
