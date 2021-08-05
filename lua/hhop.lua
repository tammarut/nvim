require("hop").setup({
  keys = 'etovxqpdygfblzhckisuran',
  vim.api.nvim_set_keymap('n', '<leader>h', "<cmd>lua require'hop'.hint_words()<cr>", {}),
  vim.api.nvim_set_keymap('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {}),
  vim.api.nvim_set_keymap('n', '<leader>p', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
})
