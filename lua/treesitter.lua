require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { 'verilog' },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" }, -- list of language that will be disabled
  },
  indent = {
    enable = true
  },
  matchup = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    colors = {
      "Gold",
      "Orchid",
      "DodgerBlue",
      -- "Cornsilk",
      -- "Salmon",
      -- "LawnGreen",
    },
  },
  autotag = {
    enable = true,
    disable = { "xml" },
  },
}
