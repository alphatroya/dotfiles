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
    })

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-copilot',
        }
    }

    -- Live-updating Neovim LSP diagnostics in quickfix and loclist
    use 'onsails/diaglist.nvim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Theme
    use 'dracula/vim'

    -- Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
    use 'tpope/vim-surround'

    -- Lualine
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Comment stuff out.
    use 'b3nj5m1n/kommentary'

    -- Vim repeat
    use 'tpope/vim-repeat'

    -- Underlines the word under the cursor
    use 'RRethy/vim-illuminate'

    -- A Vim plugin for more pleasant editing on commit messages
    use 'rhysd/committia.vim'

    -- Better whitespace highlighting for Vim
    use 'ntpeters/vim-better-whitespace'

    -- Golang support
    use {
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
        requires = {
            'AndrewRadev/splitjoin.vim',
            'buoto/gotests-vim' -- Support for gotests tool
        }
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
    use 'lukas-reineke/indent-blankline.nvim'

    -- Super fast git decorations implemented purely in lua/teal.
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- rainbow brackets
    use 'p00f/nvim-ts-rainbow'

    -- copilot
    use 'github/copilot.vim'

    -- show signature help during edition
    use 'ray-x/lsp_signature.nvim'

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

    -- FZF support
    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {
                'junegunn/fzf',
                run = ":call fzf#install()",
            },
            {'junegunn/fzf.vim'},
        },
    }

    -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
    use 'mfussenegger/nvim-lint'
end)
