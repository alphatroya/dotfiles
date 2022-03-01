-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- A universal set of defaults that (hopefully) everyone can agree on
    use 'vim-scripts/sensible.vim'

    -- LSP config
    use 'neovim/nvim-lspconfig'

    -- upstream is not updated a long time switch to the fork
    -- More info:
    -- https://github.com/glepnir/lspsaga.nvim/issues/241
    use 'tami5/lspsaga.nvim'

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-calc',
            'onsails/lspkind-nvim',
        }
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Theme
    use 'joshdick/onedark.vim'

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

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        }
    }

    -- Spell checker based on treesitter plugin
    use {
        'lewis6991/spellsitter.nvim',
        config = function()
            require('spellsitter').setup()
        end
    }

    -- A super powerful autopairs for Neovim. It support multiple character.
    use 'windwp/nvim-autopairs'

    -- Indent line plugin
    use 'lukas-reineke/indent-blankline.nvim'

    -- Super fast git decorations implemented purely in lua/teal.
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- hightlight cursor location after huge jumping
    use 'edluffy/specs.nvim'

    -- rainbow brackets
    use 'p00f/nvim-ts-rainbow'

    -- show signature help during edition
    use 'ray-x/lsp_signature.nvim'

    -- snippets support
    use {
        'hrsh7th/vim-vsnip',
        requires = {
            -- go snippets support
            'golang/vscode-go'
        }
    }

    -- support file.txt:<line>:<column> file opening
    use 'wsdjeg/vim-fetch'
end)
