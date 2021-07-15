require('gitsigns').setup {
    numhl = false,
    linehl = false,
    keymaps = {
       noremap = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    },
    watch_index = {
        interval = 1000,
        follow_files = true
    },
}

