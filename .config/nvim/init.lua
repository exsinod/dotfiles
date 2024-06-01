require("plugins")

-- Theme
require("catppuccin").setup({
    flavour = "mocha",
    background = "mocha",
    show_end_of_buffer = false,
})

-- Noice
require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    }
})

require("nvim-treesitter.configs").setup({
    ensure_installed = { "java", "lua", "rust", "json", "python", "cpp" },
})

-- LSP support
require("mason").setup()
local lsp_zero = require("lsp-zero")
require("mason-lspconfig").setup({
    ensure_installed = { "jdtls" },
    handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,

        -- this is the "custom handler" for `jdtls`
        -- noop is an empty function that doesn't do anything
        jdtls = lsp_zero.noop,
    },
})
local function setup_jdtls(_)
    local jdtls = require("jdtls")
    jdtls.start_or_attach({
        settings = {
            java = {
                eclipse = {
                    downloadSources = true,
                },
                configuration = {
                    updateBuildConfiguration = "interactive",
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                format = {
                    enabled = true,
                    settings = {
                        profile = "Default",
                        url = "/home/sven/Documents/intellij-java.xml",
                    },
                },
            },
        },
        cmd = { "/home/sven/.local/share/nvim/mason/packages/jdtls/bin/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    })
end
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("java_cmds", { clear = true }),
    pattern = { "java" },
    desc = "Setup jdtls",
    callback = setup_jdtls,
})

lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
        },
    },
})
require("lspconfig").rust_analyzer.setup({ capabilities = capabilities })
require("lspconfig").taplo.setup({ capabilities = capabilities })
require("lspconfig").tsserver.setup({ capabilities = capabilities })
require("lspconfig").yamlls.setup({ capabilities = capabilities })
require("lspconfig").pylsp.setup({ capabilities = capabilities })

local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").load {
}
local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = {

        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})
-- gradle
require("compiler").setup()
require("overseer").setup()
-- Commenting code
require("nvim_comment").setup()

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
local neogit = require('neogit')
neogit.setup {
}

-- Status line
local catppuccin = require("lualine.themes.catppuccin")
require("lualine").setup({
    options = {
        theme = catppuccin,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    ...,
})

-- nvim-tree
local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- api.hijack_cursor = true
    -- api.ignore_ft_on_setup = { "gitcommit" }
    -- api.open_on_setup = true

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "u", api.node.navigate.parent, opts("Dir up"))
    vim.keymap.set("n", "|", api.node.open.vertical, opts("V split"))
    vim.keymap.set("n", "-", api.node.open.horizontal, opts("H split"))
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
    ---
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    disable_netrw = true,
    view = { width = 50 },
    on_attach = my_on_attach,
    ---
})
-- recommended by nvim-tree to disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Telescope

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { '%.class' } },
    pickers = {
        find_files = {
            additional_args = function(_)
                return { "--hidden" }
            end,
        },
        live_grep = {
            additional_args = function(_)
                return { "--hidden" }
            end,
        },
    },
})

local set = vim.opt

-- Colorscheme with pretty colors
set.termguicolors = true
vim.cmd.colorscheme("catppuccin")

set.path:append("**")
set.number = true
set.relativenumber = false
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
-- local formatAutoGroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	command = ":FormatWrite",
-- 	group = formatAutoGroup,
-- })

-- Keymaps
-- Resizing
vim.keymap.set("n", "<M-h>", ":vertical :resize 50<CR>")
vim.keymap.set("n", "<M-j>", ":horizontal :resize 50<CR>")
-- Nvim tree
vim.keymap.set("n", "<leader>n", ":NvimTreeOpen<CR>")
-- Easy coding
-- vim.keymap.set("n", "rr", ":!cargo run<CR>")
vim.keymap.set("n", "<leader>at", ":ASToggle<CR>", {})

-- LSP
-- vim.keymap.set("n", "gd", function()
--     require("telescope.builtin").lsp_definitions({ hidden = true, layout_config = { prompt_position = "top" } })
-- end)
vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references()
end)
vim.keymap.set("n", "gi", function()
    require("telescope.builtin").lsp_implementations()
end)
-- vim.api.nvim_create_autocmd("FileType", { pattern = { "qf" }, command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]] })
vim.keymap.set("n", "grn", ":lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "gk", ":lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "go", ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "gs", ":lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "ff", ":lua vim.lsp.buf.format()<CR>")
vim.keymap.set("n", "fi", function()
    vim.lsp.buf.code_action {
        context = { only = { 'source.organizeImports' } }, apply = true
    }
end)
vim.keymap.set("n", "<leader>g", ":Neogit<CR>")

-- Obsidian
require("obsidian").setup({
    workspaces = {
        {
            name = "work",
            path = "~/Documents/devlock",
        },
    },

    -- see below for full list of options 👇
})

-- Finding
vim.keymap.set("n", "<C-g>", ":Telescope git_files<CR>")
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<M-f>", ":Telescope grep_string<CR>")
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>")
vim.keymap.set("n", "<M-V>", ":Telescope registers<CR>")
