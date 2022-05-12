--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- ————————————————
-- |   General    |
-- ————————————————
lvim.log.level = "warn"
lvim.line_wrap_cursor_movement = false
lvim.lint_on_save = true
lvim.format_on_save = false
lvim.transparent_window = true
lvim.debug = true
vim.opt.relativenumber = true
vim.opt.timeoutlen = 150 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 50
vim.opt.updatetime = 250 -- faster completion
vim.opt.redrawtime = 1500
vim.opt.wrap = false
vim.opt.guifont = "FiraCode Nerd Font:h13"
vim.opt.fillchars = {
	vert = "▕", -- alternatives │
	fold = " ",
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}
vim.opt.autoread = true
vim.opt.confirm = true
vim.opt.wildignore = {
	"*.aux,*.out,*.toc",
	"*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
	-- media
	"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
	"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
	"*.eot,*.otf,*.ttf,*.woff",
	"*.doc,*.pdf",
	-- archives
	"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
	-- temp/system
	"*.*~,*~ ",
	"*.swp,.lock,.DS_Store,._*,tags.lock",
	-- version control
	".git,.svn",
}

-- ——————————————————————————
-- |   ColorScheme (skin)   |
-- ——————————————————————————
lvim.colorscheme = "onedarker"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "mix"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_better_performance = 1

-- ———————————————
-- |   Folding   |
-- ———————————————
vim.opt.foldmethod = "indent"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.o.foldlevel = 4
vim.o.foldminlines = 1
vim.o.foldnestmax = 3

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
-- Copy here until the end line
lvim.keys.normal_mode["Y"] = "y$"
-- ▶ Keep search results at the center of screen
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["J"] = "mzJ`z"
-- Undo break points
lvim.keys.insert_mode[","] = ",<C-g>u"
lvim.keys.insert_mode["."] = ".<C-g>u"
lvim.keys.insert_mode["!"] = "!<C-g>u"
lvim.keys.insert_mode["?"] = "?<C-g>u"

--  ————————————————
--  |   Register   |
--  ————————————————
-- delete single characters without updating the default register
lvim.keys.normal_mode["x"] = [["_x]]
-- paste in visual mode without updating the default register
lvim.keys.visual_mode["p"] = [["_dP]]
lvim.keys.visual_mode["d"] = [["_d]]

--  —————————————————
--  |   Telescope   |
--  —————————————————
lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
	width = 0.80,
	height = 0.85,
	preview_cutoff = 120,
	prompt_position = "bottom",
	horizontal = {
		preview_width = function(_, cols, _)
			if cols > 200 then
				return math.floor(cols * 0.5)
			else
				return math.floor(cols * 0.6)
			end
		end,
	},
	vertical = {
		width = 0.9,
		height = 0.95,
		preview_height = 0.5,
	},

	flex = {
		horizontal = {
			preview_width = 0.9,
		},
	},
}
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
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
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- —————————— Neogit ——————————
lvim.builtin.which_key.mappings.g.s = { "<cmd>Neogit<CR>", "Neogit" }
lvim.builtin.which_key.mappings.g.a = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage hunk" }

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

-- —————————— Hop ——————————
lvim.builtin.which_key.mappings["h"] = {
	name = "+Hop",
	w = { "<cmd>HopWord<cr>", "Hop Word" },
	l = { "<cmd>HopLineStart<cr>", "Hop Line" },
}

--  —————————————————
--  |   Dashboard   |
--  —————————————————
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true

--  ————————————————
--  |   Terminal   |
--  ————————————————
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shade_terminals = true

-- —————————————————
-- |   Nvim Tree   |
-- —————————————————
lvim.keys.normal_mode["<A-f>"] = ":NvimTreeFindFile<cr>"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.hijack_netrw = 1
lvim.builtin.nvimtree.setup.open_on_setup = 1
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.view.width = 35
lvim.builtin.nvimtree.indent_markers = 1

-- ————————————————
-- |   GitSigns   |
-- ————————————————
lvim.builtin.gitsigns.opts.signcolumn = true
lvim.builtin.gitsigns.opts.word_diff = true
lvim.builtin.gitsigns.opts.keymaps = {
	["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
	["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
}
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.current_line_blame_opts = {
	virt_text = true,
	virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
	delay = 1000,
}
lvim.builtin.gitsigns.opts.current_line_blame_formatter_opts = {
	relative_time = true,
}

-- ——————————————————
-- |   Treesitter   |
-- ——————————————————
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.autotag = {
	enable = true,
	disable = { "xml" },
}
lvim.builtin.treesitter.rainbow = {
	enable = true,
	colors = {
		"Gold",
		"Orchid",
		"DodgerBlue",
		-- "Cornsilk",
		-- "Salmon",
		-- "LawnGreen",
	},
	disable = { "html" },
}
lvim.builtin.treesitter.rainbow.extended_mode = true

-- ————————————————————
-- |   LSP settings   |
-- ————————————————————
-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false
lvim.lsp.diagnostics.virtual_text = false
-- lvim.lsp.diagnostics.update_in_insert = true

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- ——————————————————————————
-- |   Additional Plugins   |
-- ——————————————————————————
-- Additional Plugins
lvim.plugins = {
	-- Gruvbox Material is a modified version of Gruvbox, the contrast is adjusted to be softer in order to protect developers' eyes.
	{ "sainnhe/gruvbox-material" },
	-- Rainbow parentheses for neovim using tree-sitter
	{ "p00f/nvim-ts-rainbow" },
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- Single tabpage interface for easily cycling through diffs for all modified files for any git rev
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
	},
	-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
	{
		"TimUntersberger/neogit",
		config = function()
			local neogit = require("neogit")
			neogit.setup({
				-- Change the default way of opening neogit
				kind = "split",
				integrations = { diffview = true },
			})
		end,
	},
	-- 🚦A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	-- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("user.hop").config()
		end,
	},
	-- Surroundings: parentheses, brackets, quotes, XML tags, and more
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
		event = "BufRead",
	},
	-- Indent guides for Neovim(Lua)
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("user.indent-line").config()
		end,
	},
	-- Smooth scrolling neovim plugin written in .lua
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("user.neoscroll").config()
		end,
	},
	{
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("user.lsp_signature").config()
		end,
	},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{ "BufWinEnter", "gitcommit", ":setlocal spell" },
}

