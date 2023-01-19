require('lspsaga').setup {
    finder_action_keys = {
        open = { '<CR>', 'o' }, vsplit = 's', split = 'i', quit = { 'q', '<esc>', '<C-c>' },
        scroll_down = '<C-f>', scroll_up = '<C-b>'
    },
    rename_in_select = false,
    code_action_keys = {
        quit = { 'q', '<esc>', '<C-c>' }, exec = '<CR>'
    },
    code_action_lightbulb = {
        enable = false,
    },
    symbol_in_winbar = {
        in_custom = false,
        enable = true,
        separator = ' ',
        show_file = true,
        click_support = false,
    },
    show_outline = {
        win_position = 'right',
        auto_enter = false,
        auto_preview = false,
        jump_key = '<CR>',
        auto_refresh = true,
    },
}
