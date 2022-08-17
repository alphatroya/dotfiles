local cmp = require 'cmp'
local lspkind = require('lspkind')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp_types = require"cmp.types.cmp"
cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noselect',
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-e>'] = cmp.mapping.close(),
        ['<M-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<down>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<up>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<CR>'] = cmp.mapping.confirm {
            select = true,
        },
    },
    formatting = {
        format = function(entry, vim_item)
            if entry.source.name == "copilot" then
                vim_item.kind = " Copilot"
                return vim_item
            end
            return lspkind.cmp_format()(entry, vim_item)
        end,
    },
    sources = {
        { name = 'copilot', group_index = 1 },
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'nvim_lsp_signature_help', group_index = 1 },
        { name = 'vsnip', group_index = 2 },
        { name = 'buffer', group_index = 2 },
    },
    experimental = {
        ghost_text = true,
    }
})

cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline(),
})

vim.api.nvim_exec([[
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Back
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
]], false)
