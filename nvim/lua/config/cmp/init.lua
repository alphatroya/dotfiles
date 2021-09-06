local cmp = require 'cmp'

vim.api.nvim_set_keymap('i', '<C-k>', '<Plug>(vsnip-expand-or-jump)', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<Plug>(vsnip-expand-or-jump)', { silent = true })
vim.api.nvim_set_keymap('v', '<C-k>', '<Plug>(vsnip-expand-or-jump)', { silent = true })

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
            elseif check_back_space() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
            else
                fallback()
            end
        end, { "i", "s", }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
            elseif check_back_space() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<S-Tab>', true, true, true), 'n')
            else
                fallback()
            end
        end, { "i", "s", }),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        {
            name = 'buffer',
            opts = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
    }
})

require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true,
  map_complete = true,
  auto_select = true,
})
