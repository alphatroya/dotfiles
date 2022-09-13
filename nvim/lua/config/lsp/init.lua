local servers = { "gopls", "jsonls", "yamlls", "phpactor", "bufls" }

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)

    local cfg = {
        use_lspsaga = true,  -- set to true if you want to use lspsaga popup
        hi_parameter = "IncSearch", -- how your parameter will be highlight
    }
    require 'illuminate'.on_attach(client)
end

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

