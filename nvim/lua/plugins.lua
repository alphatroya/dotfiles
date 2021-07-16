-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- A universal set of defaults that (hopefully) everyone can agree on
    use 'vim-scripts/sensible.vim'

    -- LSP config
    use 'neovim/nvim-lspconfig'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- Theme
    use 'joshdick/onedark.vim'

    -- Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more
    use 'tpope/vim-surround'

    -- Airline
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- Enables transparent pasting into vim. (i.e. no more :set paste!)
    use 'conradirwin/vim-bracketed-paste'

    -- Comment stuff out.
    use 'tpope/vim-commentary'

    -- Vim repeat
    use 'tpope/vim-repeat'

    -- Underlines the word under the cursor
    use 'vim-scripts/vim-cursorword'

    -- A Vim plugin for more pleasant editing on commit messages
    use 'rhysd/committia.vim'

    -- Better whitespace highlighting for Vim
    use 'ntpeters/vim-better-whitespace'
    --
    -- Golang support
    use {
        'fatih/vim-go',
        run = ':GoUpdateBinaries',
    }
    use 'buoto/gotests-vim' -- Support for gotests tool

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
    use 'lewis6991/spellsitter.nvim'

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

    -- A simple, easy-to-use Vim alignment plugin.
    use 'junegunn/vim-easy-align'

    -- Snippets support
    use 'L3MON4D3/LuaSnip'

end)

