return require("packer").startup(function(use)
    -- Packer manages itself
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin" })
    -- use({ "morhetz/gruvbox" })

    -- Noice command
    use {
        "folke/noice.nvim",
        opts = {
            -- add any options here
        },
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }

    -- Status line
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

    -- fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.x",
        requires = { { "nvim-telescope/telescope-ui-select.nvim", "nvim-lua/plenary.nvim" } },
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- git
    use({ "lewis6991/gitsigns.nvim" })
    use {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            "nvim-telescope/telescope.nvim", -- optional
        },
        config = true
    }

    -- DAP debugger
    use "mfussenegger/nvim-dap"
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

    -- LSP installation
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "mfussenegger/nvim-jdtls", requires = { "mfussenegger/nvim-dap" } },
        -- "dcampos/nvim-snippy",
        -- "dcampos/cmp-snippy",
    })
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            { "neovim/nvim-lspconfig" },
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
        },
    })
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
        requires = {
            "rafamadriz/friendly-snippets",
        }
    })
    use { 'saadparwaiz1/cmp_luasnip' }

    -- Gradle
    -- use("Zeioth/compiler.nvim")
    -- use {
    --     'stevearc/overseer.nvim',
    --     config = function() require('overseer').setup() end
    -- }
    -- tmux vim navigation
    use("christoomey/vim-tmux-navigator")

    -- Commenting code
    use("terrortylor/nvim-comment")

    -- Pretty formatting
    -- use({ "mhartington/formatter.nvim" })

    -- Good looking file navigator
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        tag = "release-please--branches--master--components--nvim-tree",
    })
    use("nvim-tree/nvim-web-devicons")

    -- Auto Save
    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({})
        end,
    })

    -- Obsidian
    use({
        "epwalsh/obsidian.nvim",
        tag = "*", -- recommended, use latest release instead of latest commit
        requires = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
    })
end)
