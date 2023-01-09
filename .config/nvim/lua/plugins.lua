return require("packer").startup(function(use)
	-- Packer manages itself
	use("wbthomason/packer.nvim")

	-- Colorscheme
	use({
		"morhetz/gruvbox",
	})

	-- Status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({ "f-person/git-blame.nvim" })

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- LSP installation
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		-- with autocomplete
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		-- with snippy
		"dcampos/nvim-snippy",
		"dcampos/cmp-snippy",
	})

	-- Commenting code
	use("terrortylor/nvim-comment")

	-- Pretty formatting
	use({ "mhartington/formatter.nvim" })

	-- Good looking file navigator
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		tag = "nightly",
	})

	-- Auto Save
	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({})
		end,
	})
end)
