require("indent_blankline").setup {
  char = "│",
  use_treesitter = true,
  show_current_context = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
  buftype_exclude = {"terminal"},
  filetype_exclude = {"help", "terminal", "text", "markdown", "git", "NvimTree"},
}
