" ----------------------------------------
" Automatic installation of vim-plug, if it's not available
" ----------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"-----------------------------------------

"-----------------------------------------
" Automatically install missing plugins on startup
"-----------------------------------------
autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
"-----------------------------------------

let mapleader = " "

let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

augroup CursorCommands
	au!
	autocmd VimEnter * silent !echo -en "\e[2 q"
	autocmd VimLeave * silent !echo -en "\e[6 q"
	autocmd VimEnter * redraw!
augroup END

filetype plugin on
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

if $COLORTERM == 'truecolor'
	set t_Co=256
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a
set number
set relativenumber
set hlsearch
set incsearch
set showmatch
set lazyredraw
set magic
set smarttab
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set shiftwidth=4
set tabstop=4

" How many tenths of a second to blink when matching brackets
set mat=2

" Better escape
inoremap kj <esc>

" Half-page movement stays centered
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'szw/vim-maximizer'
Plug 'NLKNguyen/papercolor-theme'

" Plug 'https://github.com/preservim/nerdtree'                       " Filesystem navigation
" Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} " Auto Completion
" Plug 'https://github.com/jiangmiao/auto-pairs'
" Plug 'https://github.com/vim-airline/vim-airline'

call plug#end()

nnoremap <C-w>m :MaximizerToggle<CR>

set background=dark
colorscheme PaperColor
