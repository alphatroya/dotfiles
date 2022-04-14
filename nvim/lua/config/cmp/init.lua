local cmp = require 'cmp'
local lspkind = require('lspkind')

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
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp_types.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp_types.SelectBehavior.Insert }),
        ['<CR>'] = cmp.mapping.confirm { select = true },
    },
    formatting = {
        format = lspkind.cmp_format({with_text = true, maxwidth = 50})
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
        ["<cr>"] = cmp.mapping(cmp.mapping.confirm(), {"i", "c"}),
        ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}),
        ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}),
        ["<tab>"] = cmp.mapping(
            cmp.mapping.select_next_item(),
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
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    },
    {
        { name = 'cmdline' }
    })
})

require('nvim-autopairs').setup({
    check_ts = true,
    map_bs = true,
    map_c_h = true,
    map_c_w = true,
    enable_moveright = true,
    enable_afterquote = true,
    ignored_next_char = "[%w%.]",
})

local npairs = require'nvim-autopairs'
local Rule = require'nvim-autopairs.rule'
local cond = require'nvim-autopairs.conds'
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col -1, opts.col)
      return vim.tbl_contains({ '()', '{}', '[]' }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    :with_del(function(opts)
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local context = opts.line:sub(col - 1, col + 2)
      return vim.tbl_contains({ '(  )', '{  }', '[  ]' }, context)
    end),
  Rule('', ' )')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ')' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(')'),
  Rule('', ' }')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == '}' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key('}'),
  Rule('', ' ]')
    :with_pair(cond.none())
    :with_move(function(opts) return opts.char == ']' end)
    :with_cr(cond.none())
    :with_del(cond.none())
    :use_key(']'),
}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

vim.api.nvim_exec([[
" Next snippet
imap <expr> <C-l>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'
smap <expr> <C-l>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-l>'

" Back
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
]], false)
