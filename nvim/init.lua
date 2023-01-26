-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP Configuration & Plugins
    use {
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        },
    }

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('config/lsp-saga')
        end,
    })

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                auto_install = true,
                ignore_install = { "phpdoc" },
                highlight = { enable = true },
                indent = { enable = true },
                textobjects = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aC"] = "@class.outer",
                        ["iC"] = "@class.inner",
                        ["ia"] = "@parameter.inner",
                        ["aa"] = "@parameter.outer",
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer"
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer"
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer"
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer"
                        }
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ia"] = "@parameter.inner",
                            ["aa"] = "@parameter.outer",
                        }
                    },
                }
            })
        end,
    }

    -- Theme
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.15,
                },
            }
        end
    }
    -- Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    })

    -- Lualine
    use {
        'hoob3rt/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true,
        }
    }

    -- Comment stuff out.
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Underlines the word under the cursor
    use 'RRethy/vim-illuminate'

    -- A Vim plugin for more pleasant editing on commit messages
    use 'rhysd/committia.vim'

    -- Better whitespace highlighting for Vim
    use 'ntpeters/vim-better-whitespace'

    -- Golang support
    use {
        'ray-x/go.nvim',
        requires = {
            'ray-x/guihua.lua',
        },
    }

    -- Exchange text regions
    use 'tommcdo/vim-exchange'

    -- Show mark symbols on the gutter
    use 'kshenoy/vim-signature'

    -- Replace with register (a gr* key bindings)
    use 'vim-scripts/ReplaceWithRegister'

    -- Indent line plugin
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                char = '┊',
                show_trailing_blankline_indent = false,
            }
        end,
    }

    -- Super fast git decorations implemented purely in lua/teal.
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
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

                    -- Actions
                    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>hu', gs.undo_stage_hunk)
                    map('n', '<leader>hR', gs.reset_buffer)
                    map('n', '<leader>hp', gs.preview_hunk)
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                end
            }

            require("scrollbar.handlers.gitsigns").setup()
        end
    }


    -- nvim-hlslens helps you better glance at matched information, seamlessly jump between matched instances.
    use {
        'kevinhwang91/nvim-hlslens',
        requires = {
            'petertriho/nvim-scrollbar',
        },
        config = function()
            require("scrollbar.handlers.search").setup()
        end
    }

    -- snippets support
    use {
        'hrsh7th/vim-vsnip',
        requires = {
            'hrsh7th/vim-vsnip-integ',
            -- go snippets support
            'golang/vscode-go',
        }
    }

    -- support file.txt:<line>:<column> file opening
    use 'wsdjeg/vim-fetch'

    -- Fuzzy finder support
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
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
    }

    -- todo hightlighting
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require("scrollbar").setup()
        end,
    }

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
            require('refactoring').setup {
                prompt_func_return_type = {
                    go = true,
                },

                prompt_func_param_type = {
                    go = true,
                },
            }
        end,
    }

    -- TreeSJ: split or join blocks of code
    use {
        'Wansmer/treesj',
        requires = {
            'nvim-treesitter',
        },
        config = function()
            -- (<space>m - toggle, <space>j - join, <space>s - split)
            require('treesj').setup()
        end,
    }

    use {
        'asiryk/auto-hlsearch.nvim',
        config = function()
            require("auto-hlsearch").setup()
        end,
    }

    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})


vim.o.termguicolors = true
vim.cmd.colorscheme "catppuccin-latte"

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.o.autowrite       = true -- Enable auto save before :make command
vim.o.backup          = false -- Directories for swp files
vim.o.cmdheight       = 0 -- Hide cmdline
vim.o.colorcolumn     = "120" -- Show vertical line on 90 symbols width
vim.o.cursorline      = true -- Find the current line quickly.
vim.o.expandtab       = true -- Use spaces instead of tabs.
vim.o.inccommand      = 'split' -- Enable substitution previews with inccommand
vim.o.laststatus      = 3 -- Global statusline
vim.o.lazyredraw      = true -- Only redraw when necessary.
vim.o.list            = true -- Show non-printable characters.
vim.o.report          = 0 -- Always report changed lines.
vim.o.scrolloff       = 8 -- Scroll page as soon I reaching 8 lines before edge
vim.o.shiftround      = true -- >> indents to next multiple of 'shiftwidth'.
vim.o.shiftwidth      = 4 -- >> indents by 4 spaces.
vim.o.showmatch       = true
vim.o.showmode        = true -- Show current mode in command-line.
vim.o.softtabstop     = 4 -- Tab key indents by 4 spaces.
vim.o.spell           = true -- Enable spell check
vim.o.spelllang       = "ru_ru,en_us"
vim.o.splitbelow      = true -- Open new windows below the current window.
vim.o.splitright      = true -- Open new windows right of the current window.
vim.o.swapfile        = false
vim.wo.relativenumber = true

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

vim.o.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

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

" Reselect pasted text
nnoremap gp `[v`]

" Enable syntax highlighting for ruby-based configuration files
autocmd BufNewFile,BufRead Podfile,*.podspec,Fastfile,Appfile,Matchfile set syntax=ruby

" Configure skeletons
autocmd BufNewFile *.sh 0r ~/.skeletons/bash.sh

" vim-illuminate setup
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=inverse
    autocmd VimEnter * hi LspReferenceText cterm=inverse
    autocmd VimEnter * hi LspReferenceWrite cterm=inverse
    autocmd VimEnter * hi LspReferenceRead cterm=inverse
augroup END
let g:Illuminate_delay = 1000

hi link LspInlayHint Comment

let g:markdown_fenced_languages = ['go', 'swift', 'rust', 'json']

]]   , false)

vim.g.committia_hooks = {
    diff_open = function()
        vim.wo.spell = false
    end
}

-- automatically trim whitespaces on save, provided by vim-better-whitespace plugin
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

vim.cmd('au TextYankPost * lua vim.highlight.on_yank {timeout=250, on_visual=true}') -- hightlight yank

-- save all
vim.api.nvim_set_keymap('n', '<leader>w', ':wa!<cr>', { noremap = true })

-- close active buffer
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })

-- lsp configuration
local servers = {
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
    rust_analyzer = {},
    jsonls = {},
    yamlls = {},
    bufls = {},
    sumneko_lua = {
        diagnostics = {
            globals = { 'vim' },
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
        },
    },
}

-- LSP settings.
local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
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

    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'vlua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, opts)

    require 'illuminate'.on_attach(client)
end

-- Setup mason so it can manage external tooling
require('mason').setup()

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
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.formatting.goimports,
    },
})

require('config/cmp')
require('config/mapping')

require('lualine').setup {
    options = {
        theme = 'catppuccin',
        globalstatus = true,
    },
}

vim.api.nvim_exec([[ let g:vsnip_snippet_dir = expand('~/.vsnip') ]], false)

-- go language config
require('go').setup {
    test_runner = 'richgo',
    lsp_cfg = false,
    lsp_on_attach = false,
    lsp_keymaps = false,
    lsp_gofumpt = true,
    tag_transform = 'camelcase',
    run_in_floaterm = true,
}

-- vim: ts=2 sts=2 sw=2 et
