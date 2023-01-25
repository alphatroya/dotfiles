require('lspsaga').setup {
    ui = {
        colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors(),
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    },
    rename = {
        quit = '<esc>',
        exec = '<CR>',
        mark = 'x',
        confirm = '<CR>',
        in_select = false,
    },
    code_action = {
        keys = {
            quit = {
                'q',
                '<esc>',
            },
            exec = '<CR>',
        },
    },
    lightbulb = {
        enable = false,
    },
    symbol_in_winbar = {
        enable = true,
        separator = ' ',
        show_file = true,
    },
}
