"g:gruvbox_contrastLoad .Profile to vim shell
set shell=bash\ -l
" Remove insert mode delay
set timeoutlen=1000 ttimeoutlen=0
"Intendation Config
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
"Set 256 colors
set t_Co=256
" Prevent Adding Comment on Next Line
set formatoptions-=cro
" turn hybrid line numbers on
set number relativenumber
set nu rnu
" Switch Buffer without save
set hidden
"create newline without leaving normal mode
nmap oo o<Esc>k
nmap OO O<Esc>j
"move to end of line within insert mode
inoremap <C-a> <C-o>$
"set leader key
let g:mapleader=" "
noremap <leader>a :bp<CR>
noremap <leader>s :bn<CR>
noremap <leader>q :q<CR>
noremap <leader>w :w<CR>
" leader-w makes a new split and moves to it
nnoremap <leader>v <C-w>v<C-w>l
" leader-W makes a new horizontal split and moves to it
nnoremap <leader>x <C-w>s<C-w>j
"move lines of code up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"set :find path as current path
set path+=**
" adds a selection menu above command tab while opening files
set wildmenu
" hides status bar
set laststatus=0
" hide tab bar
set showtabline=0
" vim autocomplete
set omnifunc=syntaxComplete#Complete
" Hide insert mode text as its already displayed on status bar
set noshowmode
" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Set Search Highligting on and show all matches 
set hlsearch
set incsearch
set inccommand=nosplit
" Return From Highlight Mode
:nnoremap <CR> :nohlsearch<CR><CR>
" Remap jk to ESC
inoremap jk <ESC>
"Plug Plugins
"------------------
" plug plugin manager start
call plug#begin('~/.vim/plugged')
" Vim Gutter Git Changes
Plug 'https://github.com/airblade/vim-gitgutter'
"Easy Motion Plugin
Plug 'easymotion/vim-easymotion'
" File Icons
Plug 'ryanoasis/vim-devicons'
" Intellisense autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" VIM Javascript Syntax Highlighting
Plug 'pangloss/vim-javascript'
"JSX Indentation
Plug 'mxw/vim-jsx'
" Interactive Code Results
Plug 'metakirby5/codi.vim'
" CtrlP Fuzzy Find
Plug 'ctrlpvim/ctrlp.vim'
" Styled Components Highlighting
Plug 'styled-components/vim-styled-components'
"Auto Brace Pairs
Plug 'https://github.com/jiangmiao/auto-pairs'
" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" Vim Sandwich
Plug 'machakann/vim-sandwich'
" Gruvbox Theme
Plug 'morhetz/gruvbox'
" Color Highlighting
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Fancy Vim Startup Screen
Plug 'mhinz/vim-startify'
"" Initialize plugin system
call plug#end()

" Plug Plugins Config
"
"---------------------

"Set Gruvbox Theme
colorscheme gruvbox
highlight Normal ctermbg=233
"Ctrl P Ignore Node Modules and Git
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

"COC Prettier Config
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"Remap for rename current word
nmap <C-a> <Plug>(coc-rename)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Vim Hard Mode - No Arrow Keys
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
