--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.relativenumber = true
vim.opt.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)

-- ——————————————————————————
-- |   ColorScheme (skin)   |
-- ——————————————————————————
lvim.colorscheme = "tokyonight"
vim.g.tokyonight_style = "storm"
vim.g.tokyonight_enable_italic = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_italic_functions = true

-- ———————————————
-- |   Folding   |
-- ———————————————
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- ——————————————————
-- |   Keymapping   |
-- ——————————————————
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- use the default vim behavior for H and L
lvim.keys.normal_mode["<S-l>"] = nil
lvim.keys.normal_mode["<S-h>"] = nil
-- Navigate buffers
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<CR>"
-- Move to beginning/end of line
lvim.keys.normal_mode["B"] = "^"
lvim.keys.normal_mode["E"] = "$"
-- New line in normal mode and back above
lvim.keys.normal_mode["<Enter>"] = "o<ESC>"
lvim.keys.normal_mode["<S-Enter>"] = "O<ESC>"

--  ————————————————
--  |   Register   |
--  ————————————————
-- delete single characters without updating the default register
lvim.keys.normal_mode["x"] = '"_x'
--  paste in visual mode without updating the default register
lvim.keys.visual_mode["p"] = '"_dP'
lvim.keys.visual_mode["d"] = '"_d'

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

--  —————————————————
--  |   Telescope   |
--  —————————————————
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
  -- i = {
  --   -- ["<C-j>"] = actions.move_selection_next,
  --   -- ["<C-k>"] = actions.move_selection_previous,
  --   ["<C-j>"] = actions.cycle_history_next,
  --   ["<C-k>"] = actions.cycle_history_prev,
  -- },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

--  —————————————————
--  |   Which Key   |
--  —————————————————
-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- —————————— Neogit ——————————
lvim.builtin.which_key.mappings["gs"] = nil
lvim.builtin.which_key.mappings["gs"] = { "<cmd>Neogit<CR>", "Neogit" }

-- —————————— Trouble ——————————
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- —————————— Search (highlight) ——————————
--  Press <leader> Enter to remove search highlights
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["<CR>"] = { "<cmd>nohl<CR>", "No Highlight" }

--  —————————————————
--  |   Dashboard   |
--  —————————————————
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true

-- —————————————————
-- |   Nvim Tree   |
-- —————————————————
lvim.keys.normal_mode["<A-f>"] = ":NvimTreeFindFile<cr>"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.hijack_netrw = 1
lvim.builtin.nvimtree.setup.open_on_setup = 1
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.view.width = 35
vim.g.nvim_tree_indent_markers = 1

-- ————————————————
-- |   GitSigns   |
-- ————————————————
lvim.builtin.gitsigns.opts.signcolumn = true
lvim.builtin.gitsigns.opts.word_diff = true
lvim.builtin.gitsigns.opts.keymaps = {
  ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
  ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
}
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts = {
  virt_text = true,
  virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
  delay = 1000,
}
lvim.builtin.gitsigns.opts.current_line_blame_formatter_opts = {
  relative_time = true
}

-- ——————————————————
-- |   Treesitter   |
-- ——————————————————
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "lua",
  "c",
  "javascript",
  "python",
  "typescript",
  "go",
  "godotResource",
  "gomod",
  "json",
  "css",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow = { enable = true }

-- ————————————————————
-- |   LSP settings   |
-- ————————————————————
-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black" },
  {
    exe = "prettier",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { exe = "black" },
  {
    exe = "eslint_d",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "javascriptreact" },
  },
}

-- ——————————————————————————
-- |   Additional Plugins   |
-- ——————————————————————————
lvim.plugins = {
    -- A clean, dark vim colorscheme
    {"folke/tokyonight.nvim"},
    -- Rainbow parentheses for neovim using tree-sitter
    {"p00f/nvim-ts-rainbow"},
    -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
    {'TimUntersberger/neogit'},
    {
      "folke/trouble.nvim",
      cmd = "TroubleToggle",
    },
    -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
        require("hop").setup()
        vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
        vim.api.nvim_set_keymap("n", "S", ":HopLineStart<cr>", {})
        vim.api.nvim_set_keymap("n", "<space>h", ":HopWord<cr>", { silent = true })
        vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
        vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
      end,
    },
    {
      "tpope/vim-surround",
      keys = {"c", "d", "y"}
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = function()
        vim.g.indentLine_enabled = 1
        vim.g.indent_blankline_char = "▏"
        vim.g.indent_blankline_use_treesitter = true
        vim.g.indent_blankline_show_current_context = true
        vim.g.indent_blankline_context_patterns = {"class", "function", "arrow", "method", "^if", "^while", "^for", "^object", "^table", "block", "arguments"}
        vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "markdown", "git", "NvimTree"}
        vim.g.indent_blankline_buftype_exclude = {"terminal"}
        vim.g.indent_blankline_show_trailing_blankline_indent = false
        vim.g.indent_blankline_show_first_indent_level = false
      end
    },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "gitcommit", "setlocal spell" },
}
