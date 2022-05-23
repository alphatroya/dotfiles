local cmp = require 'cmp'
local lspkind = require('lspkind')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_types = require"cmp.types.cmp"
cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
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
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp_types.SelectBehavior.Select })
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i","s","c",}),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<down>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<up>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Select }),
        ['<CR>'] = cmp.mapping.confirm { select = true },
    },
    formatting = {
        format = lspkind.cmp_format()
    },
    sources = {
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'calc'},
        { name = 'emoji'},
    },
    experimental = {
        ghost_text = true,
    }
})

cmp.setup.cmdline('/', {
    mapping = {
        ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
        ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
        ["<tab>"] = cmp.mapping(
            cmp.mapping.confirm(),
            {"i", "s", "c"}
        ),
    },
    view = {
        entries = {name = 'wildmenu', separator = '|' },
    },
    sources = {
        { name = 'buffer' }
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
