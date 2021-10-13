local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-e>'] = cmp.mapping.close(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    formatting = {
        format = lspkind.cmp_format({with_text = true, maxwidth = 50})
    },
    sources = {
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        {
            name = 'buffer',
            opts = {
                get_bufnrs = function()
                    return vim.tbl_filter(function(bufnr)
                        return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr)
                    end, vim.api.nvim_list_bufs())
                end
            },
        },
        { name = 'calc'},
        { name = 'emoji'},
    },
    experimental = {
        ghost_text = true,
    }
})

require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" , "vim" },
    enable_check_bracket_line = false,
    check_ts = true,
})

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true,
  map_complete = true,
  auto_select = true,
})

vim.api.nvim_exec([[
" Next snippet
imap <expr> <C-l>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'
smap <expr> <C-l>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'

" Back
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-l>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-l>'
]], false)
