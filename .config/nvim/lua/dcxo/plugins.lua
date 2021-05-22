vim.cmd "packadd packer.nvim"

return require('packer').startup(function()

	use 'wbthomason/packer.nvim'

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'simrat39/rust-tools.nvim'
	use 'kabouzeid/nvim-lspinstall'
    use 'glepnir/lspsaga.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'hrsh7th/vim-vsnip'
    use 'cohama/lexima.vim'

	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'nvim-treesitter/nvim-treesitter-refactor'

	use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
	use 'kyazdani42/nvim-web-devicons'

	use { 'glepnir/galaxyline.nvim', branch = 'main', config = function() require('dcxo.statusline') end, requires = {'kyazdani42/nvim-web-devicons', opt = true} }

	use 'tpope/vim-fugitive'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'

	use 'airblade/vim-gitgutter'
	use 'inkarkat/vim-ReplaceWithRegister'
	use 'svermeulen/vimpeccable'
	use 'nekonako/xresources-nvim'
    use 'glepnir/zephyr-nvim'
    use "junegunn/goyo.vim"
    use "junegunn/limelight.vim"

    use {'prettier/vim-prettier', run = "npm install"}

end)
