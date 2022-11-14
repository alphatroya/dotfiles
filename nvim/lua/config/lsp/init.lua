local servers = { "gopls", "rls", "jsonls", "yamlls", "phpactor", "bufls", "sumneko_lua" }

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    if client.server_capabilities.documentFormattingProvider then
        local au_lsp = vim.api.nvim_create_augroup("format_lsp", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
            group = au_lsp,
        })
    end

    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)

    require 'illuminate'.on_attach(client)
end

for _, lsp in ipairs(servers) do
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            },
            gopls = {
                experimentalPostfixCompletions = true,
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
                gofumpt = true,
                hints = {
                    assignVariableTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    compositeLiteralFields = true,
                    parameterNames = true,
                    rangeVariableTypes = true
                },
            },
        },
    }
end

-- golangcilsp setup
local configs = require 'lspconfig/configs'
if not configs.golangcilsp then
    configs.golangcilsp = {
        default_config = {
            cmd = { 'golangci-lint-langserver' },
            root_dir = nvim_lsp.util.root_pattern('.git', 'go.mod'),
            init_options = {
                command = { "golangci-lint", "run", "--enable-all", "--disable", "lll", "--out-format", "json",
                    "--issues-exit-code=1" };
            }
        };
    }
end

nvim_lsp.golangci_lint_ls.setup {
    filetypes = { 'go', 'gomod' }
}
