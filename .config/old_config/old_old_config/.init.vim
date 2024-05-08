call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mfussenegger/nvim-dap'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'deresmos/nvim-term'
Plug 'tmsvg/pear-tree'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'preservim/vim-markdown'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()


set nocompatible
set encoding=utf-8
set tabstop=4 		"number of columns occupied by a tab"
set softtabstop=4	"see multiple spaces as tabstops"
set expandtab		"converts tabs to whitespace"
set shiftwidth=4	"width for autoindents"
set autoindent		"indent a newline the same amount as the line just typed"
set cc=80           "set a column border after 80 characters"
set mouse=a         "enable mouse click"
set cursorline      "highlight current cursorline"
set hidden
set number

" add relative number on current working buffer and normal numbers on the rest
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

setlocal spell      "spellcheck"
set spelllang=ca,es,en_us

"map word correction to ctrl+l"
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u 

"toggle spellcheck"
nnoremap <leader>s :set spell!<cr>
syntax on
set backupdir=~/.cache/vim

"color schemes":
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
"colorscheme evening
colorscheme dracula

" open new split panes to the right and below
set splitright | set splitbelow 

" Open this config file with '<leader>v'
nnoremap <Leader>v :e $MYVIMRC<cr>

" Reloads vimrc after saving but keep cursor position
if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
   let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" C++ Compiling
let $CXX = 'g++'
let $CXXFLAGS = '-O2 -D_GLIBCXX_DEBUG -Wall -Wextra -Werror -Wno-sign-compare -std=c++11'

" Compile
nnoremap <silent> <F10> :<c-u>make %<<cr>
" Execute
nnoremap <silent> <F8> :<c-u>term ./%<<cr>

" UltiSnips config
let g:UltiSnipsExpandTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<s-tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'context'
nnoremap <silent> <F3> :UltiSnipsEdit<cr>

" NerdTree
let NERDTreeShowHidden = 1
" Exit NVim if NERDTree is the only window left
" autocmd BufEnter * 
"    \ if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() 
"    \ | quit
"    \ | endif

nnoremap <Leader>t :NERDTreeToggleVCS<cr>

" Nvim Terminal
tmap <Esc> <C-n>
" change the current working directory whenever a file is opened
autocmd BufEnter * silent! lcd %:p:h

" Startify + NERDTree on start when no file is specified
autocmd VimEnter *
    \ if !argc()
    \ | Startify
    \ | NERDTree
    \ | wincmd w
    \ | endif

" CoC config
set updatetime=300 " less delays
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate. 
" use <tab> for trigger completion and navigate to the next complete item
 inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()


"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : '\<C-h>"
"
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
 
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
endif

autocmd CursorHold * silent call CocActionAsync('highlight')

" pending more config options


"===============================
" VimTex config
"===============================
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" tex-conceal config
set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

"===============================
" PearTree config
"===============================
" Default rules for matching:
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'}
            \ }
" See pear-tree/after/ftplugin/ for filetype-specific matching rules

" Pear Tree is enabled for all filetypes by default:
let g:pear_tree_ft_disabled = []

" Pair expansion is dot-repeatable by default:
let g:pear_tree_repeatable_expand = 1

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0

" If enabled, smart pair functions timeout after 60ms:
let g:pear_tree_timeout = 60

" Automatically map <BS>, <CR>, and <Esc>
let g:pear_tree_map_special_keys = 1

" Default mappings:
imap <BS> <Plug>(PearTreeBackspace)
imap <CR> <Plug>(PearTreeExpand)
imap <Esc> <Plug>(PearTreeFinishExpansion)
" Pear Tree also makes <Plug> mappings for each opening and closing string.
"     :help <Plug>(PearTreeOpener)
"     :help <Plug>(PearTreeCloser)

" Not mapped by default:
" <Plug>(PearTreeSpace)
" <Plug>(PearTreeJump)
" <Plug>(PearTreeExpandOne)
" <Plug>(PearTreeJNR)

"===============================
" nvim-term config
"===============================

let g:nvimterm#enter_insert = 1
let g:nvimterm#toggle_tname = 'NVIM_TERM'
let g:nvimterm#toggle_size = 15
"let g:nvimterm#source_path = '~/.nvimtermrc'
let g:nvimterm#term_filetype = 'nvim-term'

"==============================
" markdown-preview config
"==============================
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

"==============================
" Others
"==============================
set title
set titlestring=%{hostname()}\ \ %F\ \ %{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}
