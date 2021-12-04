" ————————————————
" |   vim-plug   |
" ————————————————
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
" 👋 Initialize plugin system
call plug#begin('~/.config/nvim/autoload/plugged')
    " Neovim, full language server protocol support as VSCode
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " A blazing fast and easy to configure neovim statusline written in pure lua
    Plug 'hoob3rt/lualine.nvim'
    " Buffer line (with minimal tab integration) for Neovim built using lua.
    Plug 'akinsho/nvim-bufferline.lua'
    " Insert/delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'
    " Combine with netrw
    Plug 'tpope/vim-vinegar'
    " Surroundings": parentheses, brackets, quotes, XML tags, and more
    Plug 'tpope/vim-surround'
    " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
    Plug 'dense-analysis/ale'
    " JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
    Plug 'pangloss/vim-javascript'
    " The React syntax highlighting and indenting plugin for vim. Also supports the typescript tsx file.
    Plug 'maxmellon/vim-jsx-pretty'
    " TypeScript syntax
    Plug 'leafgarland/typescript-vim'
    " Auto close (X)HTML tags
    Plug 'alvan/vim-closetag'
    " gruvbox skins
    Plug 'sainnhe/gruvbox-material'
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    " Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
    Plug 'tpope/vim-commentary'
    " Indent guides for Neovim(Lua)
    Plug 'lukas-reineke/indent-blankline.nvim'
    " Nvim Treesitter configurations and abstraction layer
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Rainbow parentheses for neovim using tree-sitter
    Plug 'p00f/nvim-ts-rainbow'
    " A file explorer tree for neovim written in lua
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    " Telescope Find, Filter, Preview, Pick. All lua, all the time.
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " Smooth scrolling neovim plugin written in lua
    Plug 'karb94/neoscroll.nvim'
    " Lightning fast left-right movement (highlight for a unique character in every word on a line to help you use f, F and family)
    Plug 'unblevable/quick-scope'
    " vim-snipmate default snippets contains snippets files for various programming languages.
    Plug 'honza/vim-snippets'
    " shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks (Git signs written in pure lua)
    Plug 'lewis6991/gitsigns.nvim'
    " Jump to any location specified by two characters
    Plug 'justinmk/vim-sneak'
    " Neovim motions on speed(EasyMotion clone)
    Plug 'phaazon/hop.nvim'
    " Manage multiple terminal windows
    Plug 'akinsho/nvim-toggleterm.lua'

call plug#end()


let g:mapleader = "\<Space>" " New map <leader> from \ → spacebar

" —————————————————
" |   telescope   |
" —————————————————
" Using lua functions
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap <leader>fp <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').builtin()<cr>

" ———————————————————
" |   quick-scope   |
" ———————————————————
source $HOME/.config/nvim/plugin-config/quickscope.vim

" —————————————————
" |   vim-sneak   |
" —————————————————
source $HOME/.config/nvim/plugin-config/vim-sneak.vim

" ————————————————————
" |   vim-fugitive   |
" ————————————————————
" git status
nmap <leader>gs :G<CR>
" Accept current changes(left pane)
nmap <leader>gf :diffget //2<CR>
" Accept incoming changes(right pane)
nmap <leader>gh :diffget //3<CR>


" —————————————————————
" |   vim-closetag   |
" ————————————————————
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.js,*.jsx,*.tsx,*.md'


" ——————————————————————————————————
" |   Coc(Conquer of Completion)   |
" ——————————————————————————————————
let g:coc_global_extensions = ['coc-tsserver', 'coc-go', 'coc-prettier', 'coc-html', 'coc-css', 'coc-json', 'coc-snippets']
let g:coc_disable_startup_warning = 1
let g:coc_disable_transparent_cursor = 1

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ⋯⋯⌨ Custom keymap
nmap <leader>rr <Plug>(coc-rename)
" prw = project rename word
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)

" ——————————————————————————————————
" |   vim-snippets(coc-snippets)   |
" ——————————————————————————————————
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" ——————————————————————————————
" |   Prettier(coc-prettier)   |
" ——————————————————————————————
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" —————————————————————————————————————
" |   ale(Asynchronous Lint Engine)   |
" —————————————————————————————————————
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'typescriptreact': ['tsserver','tslint'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier','eslint'],
\   'typescript': ['prettier','eslint'],
\   'typescriptreact': ['prettier','eslint'],
\    'html': ['prettier'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_sign_error = '✗'
let g:ale_sign_warning = ''
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma none'
let g:ale_javascript_prettier_use_local_config = 1
" Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 1


" ——————————————————————————————————————
" |   yats(.tsx syntax highlighting)   |
" ——————————————————————————————————————
let g:yats_host_keyword = 1

" ——————————————————————
" |   vim-jsx-pretty   |
" ——————————————————————
let g:jsx_ext_required = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0
let g:vim_jsx_pretty_highlight_close_tag = 1"

" ——————————————————————
" |   vim-javascript   |
" ——————————————————————
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1  " enables syntax highlighting

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"        stop once at the start of insert.
set backspace=indent,eol,start

" ——————————————————————
" |   Normal setting   |
" ——————————————————————
set number relativenumber  " turn hybrid line number on
set showcmd "show command in bottom bar
set noshowmode " hide vim status -- INSERT --
set cursorline  "highlight current line
set wildmenu   "visual autocomplete for command menu
set wildmode=full
set lazyredraw  "redraw only when we need to
set timeoutlen=250  " By default timeoutlen is 1000 ms"
set showmatch  "highlight matching [{()}]
set autowrite
set redrawtime=10000
set synmaxcol=180
set scrolloff=10
set sidescrolloff=8
set re=1
" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8
autocmd VimResized * wincmd = " Automatically equalize splits when Vim is resized

" —————————— Improve scroll performance ——————————
augroup syntaxSyncMinLines
    autocmd!
    autocmd Syntax * syntax sync minlines=2000
augroup END

" ———————————
" |   Tab   |
" ———————————
set tabstop=2   " number of visual spaces per TAB
set shiftwidth=2  " when indenting with '>', use 4 spaces width
set softtabstop=2   " Sets the number of columns for a TAB.
set expandtab   " On pressing tab, insert 4 spaces
set shiftround " Shift to the next round tab stop.
set autoindent " Auto indent
set smartindent " make indenting smarter again


" —————————— Vim's Built-in for Autocompleting words ——————————
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
" ⇨ Select the complete menu item like CTRL+y world.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

" ———————————————
" |   Register   |
" ———————————————
" delete single characters without updating the default register
noremap x "_x
" paste in visual mode without updating the default register
vnoremap p "_dP
vnoremap d "_d


" ——————————————————————
" |   Spell checking   |
" ——————————————————————
autocmd FileType gitcommit setlocal spell
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" ———————————————
" |   Folding   |
" ———————————————
set foldmethod=indent
set foldlevelstart=99
set foldexpr=nvim_treesitter#foldexpr()

" ———————————————————————————
" |   New movement keymap   |
" ———————————————————————————
inoremap hh <ESC>
inoremap jk <ESC>
inoremap <A-c> <ESC> ""

" ————————————————————————
" |   Utilize Shortcut   |
" ————————————————————————
" Save file by Ctrl-s
nnoremap <C-s> :w<cr>
" Move to beginning/end of line
nnoremap B ^
nnoremap E $
" New line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>
" Copy here until the end line
nnoremap Y y$
nnoremap J mzJ`z
" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" —————————————————————
" |   Mouse enabled   |
" —————————————————————
set mouse=a

" ——————————————————————————————————————————————————————
" |   Navigate around splits with a single key combo   |
" ——————————————————————————————————————————————————————
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Use alt + hjkl to resize windows
nnoremap <A-j> :resize -2<CR>
nnoremap <A-k> :resize +2<CR>
nnoremap <A-l> :vertical resize -2<CR>
nnoremap <A-h> :vertical resize +2<CR>

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" ——————————————————————————————————————————
" |   Move lines up/down in varios modes   |
" ——————————————————————————————————————————
inoremap <C-j> :m .+1<CR>==
inoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ————————————————
" |   Terminal   |
" ————————————————
" noremap <Leader>t :below 10sp term://zsh<CR>
tnoremap hh <C-\><C-n>

" ————————————————————
" |   Scheme(skin)   |
" ————————————————————
syntax on
if (has('termguicolors'))
  set termguicolors " this variable must be enabled for colors to be applied properly

endif
set background=dark
" set contrast
" this configuration option should be placed before `colorscheme
" available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_invert_selection='0'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_current_word = 'bold'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" —————————————————————————
" |   Search(highlight)   |
" —————————————————————————
set hlsearch   " Enable highlight the current search
set ignorecase " Make search case insensitive...
set smartcase " ... except when we use uppercase letters
set incsearch " Highlight while search


" Press <leader> Enter to remove search highlights
noremap <silent> <leader><cr> :nohl<cr>

" ▶ Keep search results at the center of screen
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zz
nnoremap # #zz

" ▶ Search down into subdirectories
" Provides tab-completion for all file-related tasks
set path+=**

" ————————————————————————
" |   WSL yank support   |
" ————————————————————————
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
    augroup END
endif
set clipboard=unnamedplus  " Copy to clipboard "+y

" —————————————————
" |   Nvim Tree   |
" —————————————————
nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <A-f> :NvimTreeFindFile<CR>

let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_refresh_wait = 800 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }

" ———————————————————————
" |   nvim-bufferline   |
" ———————————————————————
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete
" ———————— Remapping key(work around buffers) —————————
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent> <tab> :BufferLineCycleNext<CR>
nnoremap <silent> <s-tab> :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>d :lclose<bar>b#<bar>bd #<CR>
