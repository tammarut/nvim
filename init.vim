set runtimepath^=/.vim runtimepath+=~/.vim/after

let &packpath = &runtimepath

source ~/.config/nvim/vimrc
luafile ~/.config/nvim/lua/treesitter.lua
