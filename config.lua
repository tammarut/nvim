--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- ————————————————
-- |   General    |
-- ————————————————
lvim.log.level = "warn"
lvim.line_wrap_cursor_movement = false
lvim.format_on_save = true
lvim.transparent_window = false
lvim.debug = false
vim.opt.relativenumber = true
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.wrap = true


-- ——————————————————————————
-- |   ColorScheme (skin)   |
-- ——————————————————————————
lvim.colorscheme = "gruvbox-material"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_palette = "mix"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_better_performance = 1

-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_enable_italic = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.g.tokyonight_italic_functions = true

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

-- —————————— GitUI ——————————
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gitui", "gg", "GitUI"}

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

--  ————————————————
--  |   Terminal   |
--  ————————————————
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shade_terminals = true
lvim.builtin.terminal.on_config_done = function()
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    direction = 'float',
    float_opts = {
      width = function()
        return vim.o.columns
      end,
      height = function(_term)
        local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines / 20)))
        _term.float_opts.row = vim.o.lines - height
        return height
      end,
      border = { "─", "─", "─", " ", "─", "─", "─", " " },
      highlights = {
        -- background = "NormalFloat",
        border = "SpecialComment"
      },
      winblend = 7
    },
    close_on_exit = true
  })
  function _ToggleTerm()
    term:toggle()
  end

  local gitui = Terminal:new({
    cmd = 'gitui',
    direction = 'float',
    float_opts = {
      width = function()
        return vim.o.columns
      end,
      border = 'solid',
    },
    close_on_exit = true
  })
  function _ToggleGitUI()
    gitui:toggle()
  end
end

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
lvim.builtin.treesitter.ensure_installed = "maintained"
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
-- require'lspconfig'.gopls.setup{}
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

-- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   {
--     exe = "prettier",
--     filetypes = {
--       "javascriptreact",
--       "javascript",
--       "typescriptreact",
--       "typescript",
--       "json",
--       "markdown",
--     },
--     args = { "--print-with", "120", "--no-semi", "--single-quote", "--jsx-single-quote" },
--   }
-- }
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   -- { exe = "black" },
--   {
--     exe = "prettier",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "json"},
--   },
-- }

-- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   {
--     exe = "eslint",
--     filetypes = {
--       "javascriptreact",
--       "javascript",
--       "typescriptreact",
--       "typescript",
--     },
--   },
-- }
-- linters.setup {
--   -- { exe = "black" },
--   {
--     exe = "eslint_d"
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     -- filetypes = { "javascript", "javascriptreact" },
--   },
-- }

-- ——————————————————————————
-- |   Additional Plugins   |
-- ——————————————————————————
lvim.plugins = {
    -- A clean, dark vim colorscheme
    {"folke/tokyonight.nvim"},
    -- Gruvbox Material is a modified version of Gruvbox, the contrast is adjusted to be softer in order to protect developers' eyes.
    {'sainnhe/gruvbox-material'},
    -- Rainbow parentheses for neovim using tree-sitter
    {"p00f/nvim-ts-rainbow"},
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
      config = function ()
        local neogit = require("neogit")
        neogit.setup {
          integrations = { diffview = true }
        }
      end
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
      keys = {"c", "d", "y"}
    },
    -- Indent guides for Neovim(Lua)
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("user.indent-line").config()
      end
    },
    -- Smooth scrolling neovim plugin written in .lua
    {
      "karb94/neoscroll.nvim",
      event = "WinScrolled",
      config = function()
       require("user.neoscroll").config()
      end
    },
    {
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        local tabnine = require "cmp_tabnine.config"
        tabnine:setup {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = '..'
        }
      end,

    },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "gitcommit", "setlocal spell" },
   -- On entering insert mode in any file, scroll the window so the cursor line is centered
  -- { "InsertEnter", "*", ":normal zz" },
}

