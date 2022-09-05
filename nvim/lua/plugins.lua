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
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                auto_install = true,
                ignore_install = { "phpdoc" },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = {
                    enable = true,
                },
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
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
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
        requires = {'ray-x/guihua.lua'},
    }

    -- Exchange text regions
    use 'tommcdo/vim-exchange'

    -- Additional next/previous mapping
    use 'tpope/vim-unimpaired'

    -- Show mark symbols on the gutter
    use 'kshenoy/vim-signature'

    -- Replace with register (a gr* key bindings)
    use 'vim-scripts/ReplaceWithRegister'

    -- Spell checker based on treesitter plugin
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    -- A super powerful autopairs for Neovim. It support multiple character.
    use 'jiangmiao/auto-pairs'

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
            'nvim-lua/plenary.nvim'
        }
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
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('telescope').setup{}
        end
    }

end)
