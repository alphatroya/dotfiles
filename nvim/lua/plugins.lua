-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- A universal set of defaults that (hopefully) everyone can agree on
    use 'tpope/vim-sensible'

    -- LSP config
    use 'neovim/nvim-lspconfig'

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
    use { "catppuccin/nvim", as = "catppuccin" }

    -- Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit for the latest features
        config = function()
            require("nvim-surround").setup()
        end
    })

    -- Lualine
    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
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
        requires = { 'ray-x/guihua.lua' },
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
            require("indent_blankline").setup {}
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
            -- require('hlslens').setup()
            require("scrollbar.handlers.search").setup({
            })
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
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
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
        'williamboman/mason-lspconfig.nvim',
        requires = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
            'jose-elias-alvarez/null-ls.nvim',
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.code_actions.refactoring,
                    null_ls.builtins.diagnostics.checkmake,
                    null_ls.builtins.formatting.goimports,
                },
            })
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
end)
