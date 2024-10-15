-- Install lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup({
    -- LSP Configuration & Plugins
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        },
    },

    -- Autocomplete
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        }
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },

    -- Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
    {
        'kylechui/nvim-surround',
        config = true,
    },

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' }
    },

    -- Underlines the word under the cursor
    'RRethy/vim-illuminate',

    -- A Vim plugin for more pleasant editing on commit messages
    'rhysd/committia.vim',

    -- Show mark symbols on the gutter
    'kshenoy/vim-signature',

    -- Replace with register (a gr* key bindings)
    'vim-scripts/ReplaceWithRegister',

    -- Indent line plugin
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },

    -- Super fast git decorations implemented purely in lua/teal.
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'petertriho/nvim-scrollbar',
        },
        config = function()
            require('gitsigns').setup {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                numhl = true,
                linehl = false,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Next git hunk" })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = "Previous git hunk" })

                    -- Actions
                    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>',
                        { desc = "[H]unk [s]tage" })
                    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>',
                        { desc = "[H]unk [r]eset" })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[H]unk stage [u]ndo" })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = "[H]unk [p]review" })
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end,
                        { desc = "[H]unk trigger [b]lame" })
                end
            }
        end
    },

    -- snippets support
    {
        'hrsh7th/vim-vsnip',
        dependencies = {
            'hrsh7th/vim-vsnip-integ',
            -- go snippets support
            'golang/vscode-go',
        }
    },

    -- support file.txt:<line>:<column> file opening
    'wsdjeg/vim-fetch',

    -- Fuzzy finder support
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        keys = {
            { '<leader>sf', ':Telescope git_files theme=dropdown<CR>', silent = true, desc = '[S]earch [F]iles' },
            { '<leader>sc', ':Telescope git_status<CR>',               silent = true, desc = '[S]earch [C]hanged' },
            { '<leader>sg', ':Telescope live_grep<CR>',                silent = true, desc = '[S]earch by [G]rep' },
            { '<leader>sw', ':Telescope grep_string<CR>',              silent = true, desc = '[S]earch current [W]ord' },
            { '<leader>s/', ':Telescope resume<CR>',                   silent = true },
            {
                '<leader>?',
                ':Telescope oldfiles<CR>',
                silent = true,
                desc =
                '[?] Find recently opened files'
            },
            {
                '<leader>sd',
                function()
                    require('telescope.builtin').diagnostics()
                end,
                desc = '[S]earch [D]iagnostic'
            },
            {
                '<leader>sk',
                function()
                    require('telescope.builtin').keymaps()
                end,
                desc = '[S]earch [K]eymaps'
            },
            {
                '<leader>ss',
                function()
                    require('telescope.builtin').lsp_document_symbols()
                end,
                silent = true,
                desc = '[S]earch Document [S]ymbols'
            },
            {
                '<leader><leader>',
                function()
                    require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })
                end,
                silent = true,
                desc = '[ ] Find existing buffers'
            },
            {
                "<leader>gr",
                function()
                    require('telescope.builtin').lsp_references(require('telescope.themes')
                        .get_dropdown({
                            show_line = false }))
                end,
                silent = true,
                desc = '[G]oto [R]eferences'
            },
            { '<leader>sn', function()
                require("telescope.builtin").find_files({ cwd = require('telescope.utils').buffer_dir() })
            end, { silent = true, desc = '[S]earch [N]eighbors' } },
            { '<leader>/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
                    .get_dropdown {
                        winblend = 10,
                        previewer = false,
                    })
            end, { desc = '[/] Fuzzily search in current buffer]' } },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                },
            }
            require("telescope").load_extension("ui-select")
        end
    },

    -- todo hightlighting
    {
        'folke/todo-comments.nvim',
        name = "todo-comments",
        dependencies = 'nvim-lua/plenary.nvim',
        keys = {
            { "<leader>st", ':TodoTelescope<CR>', desc = '[S]earch [T]ODO marks' },
        },
        opts = {},
    },

    -- TreeSJ: split or join blocks of code
    -- (<space>m - toggle, <space>j - join, <space>s - split)
    {
        'Wansmer/treesj',
        dependencies = {
            'nvim-treesitter',
        },
        opts = {},
    },

    {
        'smjonas/inc-rename.nvim',
        config = function()
            require('inc_rename').setup()
        end,
    },

    -- A plugin that makes Neovim more friendly to non-English input methods 🤝
    {
        'Wansmer/langmapper.nvim',
        lazy = false,
        priority = 1,
        config = function()
            require('langmapper').setup()
        end,
    },

})

vim.o.termguicolors = true
vim.cmd.colorscheme "tokyonight"

-- Set highlight on search
vim.o.hlsearch        = true

-- Make line numbers default
vim.wo.number         = true

-- Enable break indent
vim.o.breakindent     = true

-- Save undo history
vim.o.undofile        = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase      = true
vim.o.smartcase       = true

-- Decrease update time
vim.o.updatetime      = 250
vim.wo.signcolumn     = 'yes'

vim.o.autowrite       = true    -- Enable auto save before :make command
vim.o.backup          = false   -- Directories for swp files
vim.o.cmdheight       = 0       -- Hide cmdline
vim.o.colorcolumn     = "120"   -- Show vertical line on 90 symbols width
vim.o.cursorline      = true    -- Find the current line quickly.
vim.o.expandtab       = true    -- Use spaces instead of tabs.
vim.o.inccommand      = 'split' -- Enable substitution previews with inccommand
vim.o.laststatus      = 3       -- Global statusline
vim.o.list            = true    -- Show non-printable characters.
vim.o.scrolloff       = 8       -- Scroll page as soon I reaching 8 lines before edge
vim.o.shiftround      = true    -- >> indents to next multiple of 'shiftwidth'.
vim.o.shiftwidth      = 4       -- >> indents by 4 spaces.
vim.o.showmatch       = true
vim.o.showmode        = false   -- Disabled for hardtime
vim.o.softtabstop     = 4       -- Tab key indents by 4 spaces.
vim.o.spell           = true    -- Enable spell check
vim.o.spelllang       = "ru_ru,en_us"
vim.o.splitbelow      = true    -- Open new windows below the current window.
vim.o.splitright      = true    -- Open new windows right of the current window.
vim.o.swapfile        = false
vim.wo.relativenumber = true

-- Avoid showing extra messages when using completion
vim.opt.shortmess     = vim.opt.shortmess + "c"

-- Comfigure langmap (https://github.com/Wansmer/langmapper.nvim#settings)
local function escape(str)
    -- You need to escape these characters to work correctly
    local escape_chars = [[;,."|\]]
    return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
    -- | `to` should be first     | `from` should be second
    escape(ru_shift) .. ';' .. escape(en_shift),
    escape(ru) .. ';' .. escape(en),
}, ',')
--- End langmap config

vim.api.nvim_set_keymap('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { expr = true, noremap = true })

vim.api.nvim_exec(
    [[
" Safe command remapping, see https://stackoverflow.com/questions/3878692/how-to-create-an-alias-for-a-command-in-vim/3879737#3879737
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")' .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Qall","qall")
call SetupCommandAlias('Wq', 'wq')
call SetupCommandAlias('Wa', 'wa')
call SetupCommandAlias('wQ', 'wq')
call SetupCommandAlias('WQ', 'wq')
call SetupCommandAlias('Ц', 'w')
call SetupCommandAlias('ц', 'w')
call SetupCommandAlias('Й', 'q')
call SetupCommandAlias('й', 'q')
call SetupCommandAlias('Цй', 'wq')
call SetupCommandAlias('ЦЙ', 'wq')
call SetupCommandAlias('цй', 'wq')

" Disable command line history mode
nnoremap q: <nop>
nnoremap Q <nop>

]], false)

-- Enable syntax highlighting for ruby-based configuration files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Fastfile", "Appfile", "Matchfile", "Podfile", "Podfile.lock", "*.podspec" },
    command = "set filetype=ruby"
})

vim.g.committia_hooks = {
    diff_open = function()
        vim.wo.spell = false
    end
}

vim.g.markdown_fenced_languages = { 'go', 'swift', 'rust', 'json' }

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {timeout=250, on_visual=true}') -- hightlight yank

vim.api.nvim_set_keymap('n', '<leader>w', '<Cmd>silent! update | redraw<CR>', {
    noremap = true,
    silent = true,
    desc = "Quick save buffer",
})

vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, desc = "Close active buffer" })

-- lsp configuration
local servers = {
    bashls = {},
    gopls = {
        gopls = {
            usePlaceholders = false,
            completeUnimported = true,
            experimentalPostfixCompletions = true,
            analyses = {
                unreachable = true,
                nilness = true,
                unusedparams = true,
                useany = true,
                unusedwrite = true,
                undeclaredname = true,
                fillreturns = true,
                nonewvars = true,
                fieldalignment = false,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
    rust_analyzer = {},
    jsonls = {},
    yamlls = {},
    bufls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- LSP settings.
local on_attach = function(client, bufnr)
    -- Reformat code on save
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

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'vlua.vim.lsp.omnifunc')

    -- Mappings.
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = "Re[f]ormat code",
    })

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
        noremap = true,
        silent = true,
        buffer = bufnr,
        desc = "[C]ode [A]ctions",
    })

    require 'illuminate'.on_attach(client)
end

-- Setup mason so it can manage external tooling
require('mason').setup()

require 'lspconfig'.sourcekit.setup {}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.formatting.trim_whitespace,
        null_ls.builtins.diagnostics.trail_space,
    },
    on_attach = on_attach,
})

require('config/cmp')
require('config/mapping')

require('lualine').setup {
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
        },
    },
}

-- custom snippets folder
vim.api.nvim_exec([[ let g:vsnip_snippet_dir = expand('~/.vsnip') ]], false)

require('langmapper').automapping({ global = true, buffer = true })
