

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'famiu/bufdelete.nvim'
	use {
	  'kyazdani42/nvim-tree.lua',
	  requires = {
	    'kyazdani42/nvim-web-devicons',
	  },
	  tag = 'nightly'
	}
	
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

  use 'Olical/conjure'

	use 'Mofiqul/dracula.nvim'

	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

	use { "github/copilot.vim" }

	use { "nvim-lua/plenary.nvim" }

	use {"windwp/nvim-spectre", config = function()
	  require("spectre").setup()
	end}

  use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
	
	use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function()
	  require("toggleterm").setup()
	end}

	use {'karb94/neoscroll.nvim', config = function()
	  require("neoscroll").setup{
	      mappings = {'<C-u>', '<C-d>'}
	  }
	end}

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    "williamboman/nvim-lsp-installer"
  }

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin

  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp

  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp

  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use { 'neovim/nvim-lspconfig', requires = { 'nvim-lua/lsp-status.nvim' } }

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup({
            toggler = {
              line = '<C-_>',
            },
            opleader = {
              line = '<C-_>',
            },
          })
      end
  }
end)
