set runtimepath^=/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.config/nvim/vimrc
luafile ~/.config/nvim/lua/treesitter.lua
luafile ~/.config/nvim/lua/gitsigns.lua
luafile ~/.config/nvim/lua/neoscrolls.lua
