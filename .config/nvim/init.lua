require("plugins")

-- LSP support
require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "snippy" },
	}, {
		{ name = "buffer" },
	}),
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").rust_analyzer.setup({ capabilities = capabilities })
require("lspconfig").java_language_server.setup({ capabilities = capabilities })
require("lspconfig").taplo.setup({ capabilities = capabilities })
require("lspconfig").tsserver.setup({ capabilities = capabilities })
require("lspconfig").yamlls.setup({ capabilities = capabilities })

-- Commenting code
require("nvim_comment").setup()

-- require("git-blame").setup()

-- Pretty formatting
require("formatter").setup({
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		yaml = {
			require("formatter.filetypes.yaml").yamlfmt,
		},
	},
})

-- Status line
local custom_gruvbox = require("lualine.themes.gruvbox")
require("lualine").setup({
	options = { theme = custom_gruvbox },
	...,
})

-- nvim-tree
require("nvim-tree").setup({
	view = {
		mappings = {
			list = {
				{ key = "u", action = "dirup" },
				{ key = "|", action = "vsplit" },
				{ key = "-", action = "split" },
			},
		},
	},
	ignore_ft_on_setup = { "gitcommit" },
	open_on_setup = true,
	open_on_setup_file = true,
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
})
-- recommended by nvim-tree to disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Telescope
require("telescope").setup({
	pickers = {
		find_files = {
			additional_args = function(opts)
				return { "--hidden" }
			end,
		},
		live_grep = {
			additional_args = function(opts)
				return { "--hidden" }
			end,
		},
	},
})

local set = vim.opt

-- Colorscheme with pretty colors
set.termguicolors = true
vim.cmd("colorscheme gruvbox")

set.path:append("**")
set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"
set.hidden = true
set.wrap = false

set.undofile = true
set.undodir = os.getenv("XDG_CACHE_HOME") .. "/nvim/undo"

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

-- Autocommands
-- format after save
--
local formatAutoGroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	command = ":FormatWrite",
	group = formatAutoGroup,
})

-- Keymaps
-- Nvim tree
vim.keymap.set("n", "<leader>n", ":NvimTreeOpen")
-- Easy coding
vim.keymap.set("n", "rr", ":!cargo run<CR>")
vim.keymap.set("n", "<leader>at", ":ASToggle<CR>", {})

-- LSP
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "gk", ":lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "go", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "gs", ":lua vim.lsp.buf.code_action()<CR>")

-- Finding
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>")

-- Easy window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
