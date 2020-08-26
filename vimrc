" 📎—————————————— vim-plug ——————————————
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/autoload/plugged')
    " Neovim, full language server protocol support as VSCode
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
    Plug 'airblade/vim-gitgutter'
    " lean & mean status/tabline for vim that's light as air
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
    Plug 'dense-analysis/ale'
    " Insert/delete brackets, parens, quotes in pair
    Plug 'jiangmiao/auto-pairs'
    " Go development plugin for Vim
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " JavaScript bundle for vim, this bundle provides syntax highlighting and improved indentation.
    Plug 'pangloss/vim-javascript'
    " post instalyaryarnnl (yarn install | npm install) then load plugin only for editing supported files
    Plug 'prettier/vim-prettier', { 'do': 'npm install' }
    " Rainbow Parentheses
    Plug 'luochen1990/rainbow'
    " Combine with netrw
    Plug 'tpope/vim-vinegar'
    " The React syntax highlighting and indenting plugin for vim. Also supports the typescript tsx file.
    Plug 'maxmellon/vim-jsx-pretty'
    " Auto close (X)HTML tags
    Plug 'alvan/vim-closetag'
    " gruvbox skins
    Plug 'gruvbox-community/gruvbox'
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    " Comment stuff out. Use gcc to comment out a line (takes a count), gc to comment out the target of a motion
    Plug 'tpope/vim-commentary'
    " Simple indentation guides for your buffers
    Plug 'thaerkh/vim-indentguides'
    " Searching in Vim as easy as searching in modern editors/IDEs.
    Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
    Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" —————————— fzf ——————————
map <C-p> :GFiles<CR>
map <leader>b :Buffers<CR>
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'  } }

let $FZF_DEFAULT_OPTS = '--layout=reverse'
" Tell FZF to use RG - so we can skip .gitignore files even if not using
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
nnoremap <leader>gc :GCheckout<CR>

" —————————— vim-fugitive ——————————
" git status
nmap <leader>gs :G<CR>
" Accept current changes(left pane)
nmap <leader>gf :diffget //2<CR>
" Accept incoming changes(right pane)
nmap <leader>gh :diffget //3<CR>

" —————————— vim-closetag ——————————
" filenames like *.xml, *.html, *.xhtml, ...
" " These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.html.erb,*.md'

" ——————————— Coc(Conquer of Completion) ———————————
let g:coc_disable_startup_warning = 1

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{FugitiveStatusline()}

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


" ——————————— YML ———————————
" Skip re-indenting lines after a comment #, after a colon : or at the
" beginning of a line.
" ts (tabstop) a <Tab> key will count as two spaces
" sw (shiftwidth) identation and auto-identation will use two spaces (eg. when
" using >> or gg=G)
" sts (softtabstop) a <Tab> will count for two spaces when expanding tabs
" (inserting a tab, or using the Backspace key)
" expandttab use spaces instead of tabs
" foldmethod folding will be based on indentation levels
" nofoldenable the file will be opened without any folds
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:> foldmethod=indent nofoldenable

" ————————— ale —————————
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier','eslint'],
\}


" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" ————————— vim-javascript  ———————————
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1  " enables syntax highlighting

" ————————— vim-prettier  ———————————
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#config#tab_width = 2
let g:prettier#exec_cmd_async = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" ============== vim-go ============== "

" Allow backspace to delete indentation and inserted text
" i.e. how it works in most programs
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"        stop once at the start of insert.
set backspace=indent,eol,start

" go-vim plugin specific commands
" Also run `goimports` on your current file on every save
" Might be be slow on large codebases, if so, just comment it out
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1  " Automatically get signature/type info for object under cursor
let g:go_highlight_types = 1  " beautify highlight 'type'
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1  " highlight my function and method
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1  " highlight function and method invocations
let g:go_highlight_operators = 1  " highlight operators
let g:go_auto_sameids = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_experimental = 1
let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['golint', 'govet']

" Autocomplete prompt to appear automatically when press .(dot)
"au filetype go inoremap <buffer> . .<C-x><C-o>

" ============== Rainbow brackets Configuration ============== "
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle


" ============== Git Gutter ============== "
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
let g:gitgutter_enabled = 1

" ============== Vim airline ============== "
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" ============== Normal setting ============== "
set number relativenumber  " turn hybrid line number on
set showcmd "show command in bottom bar
set tabstop=2   " number of visual spaces per TAB
set shiftwidth=2  " when indenting with '>', use 4 spaces width
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab   " On pressing tab, insert 4 spaces
set cursorline  "highlight current line
set wildmenu   "visual autocomplete for command menu
set lazyredraw  "redraw only when we need to
set showmatch  "highlight matching [{()}]
set autowrite
" Change how vim represents characters on the screen
set encoding=utf-8

" Set the encoding of files written
set fileencoding=utf-8

" —————————— Vim's Built-in for Autocompleting words ——————————
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
" ⇨ Select the complete menu item like CTRL+y world.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"

" ============== New movement keymap ============== "
inoremap hh <ESC>
inoremap <A-c> <ESC> ""
noremap ; l
noremap l k
noremap k j
noremap j h

" ————————— Insert newline without exit insert mode ————————
inoremap <S-cr> <ESC>o
inoremap <C-s> :w<CR>

" ————————— Mouse enabled —————————
set mouse=a

" ————————— Navigate around splits with a single key combo. —————————
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

"============== Terminal ============== "
noremap <Leader>t :below 10sp term://bash<CR>
tnoremap hh <C-\><C-n>

" ============== Skin ============== "
syntax on
set background=dark
colorscheme gruvbox

" ================ Search ================= "
set incsearch  " Highlight as you search
set hlsearch   " Highlight the current search
set ignorecase " Make search case insensitive...
set smartcase  " ... except when we use uppercase letters

" Search down into subdirectories
" Provides tab-completion for all file-related tasks
set path+=**

" ================ WSL yank support  ================= "
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
    augroup END
endif
set clipboard=unnamedplus  " Copy to clipboard "+y


" ================ Netrw magic  ================= "
let g:netrw_banner = 0 "hide netrw top banner
let g:netrw_list_hide = '.*\.swap$'  " Hide vim.swp files
let g:netrw_liststyle = 3  " Change the directory view in netrw
let g:netrw_browse_split = 4 " Open file on same windows vim
"let g:netrw_altv = 1   " Open files in vertical
let g:netrw_winsize = 20 " size of left window


" ========== Open to Right========== "
function! OpenToRight()
        :normal v
        let g:path=expand('%:p')
        :q!
        execute 'belowright vnew' g:path
        :normal <C-l>
endfunction

" ========== Open to Below ========== "
function! OpenToBelow()
        :normal v
        let g:path=expand('%:p')
        :q!
        execute 'belowright new' g:path
        :normal <C-l>
endfunction

" =========== Mapping key OpenRight/OpenBelow ========== "
function! NetrwMappings()
        " Hack fix to make ctrl-l work properly
        noremap <buffer> <C-l> <C-w>l
        noremap <silent> <A-b> :call ToggleNetrw()<CR>
        noremap <buffer> V :call OpenToRight()<cr>
        noremap <buffer> H :call OpenToBelow()<cr>
endfunction

" =========== Run Mapping function automatically ========== "
augroup netrw_mappings
        autocmd!
        autocmd filetype netrw call NetrwMappings()
augroup END

" ======== Allow for netrw to be toggled explorer ========
let g:NetrwIsOpen=0  " Make sure that netrw is open variable
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

" Close Netrw if it's the only buffer open
"autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" ========== Open netrw automatically like a project Draw ========== "
augroup ProjectDrawer
  autocmd!
  if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
      silent exe "bwipeout " . bufnr("$")
      exe 'cd '.argv()[0]
      autocmd VimEnter * :call ToggleNetrw()
  else
      autocmd VimEnter * :call ToggleNetrw()
      autocmd VimEnter * wincmd p
  endif
augroup END



" ==================== Buffers  ===================== "
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete
" ———————— Remapping key ————————— "
nnoremap  <silent> <tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab> :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap <silent> <leader>d :lclose<bar>b#<bar>bd #<CR>
