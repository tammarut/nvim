set runtimepath^=/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.config/nvim/vimrc

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "c", "rust" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
