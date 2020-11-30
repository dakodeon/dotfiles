" plugins!
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-expand-region'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dahu/vim-help'
Plug 'tomasiser/vim-code-dark'

call plug#end()

" set leader key to space
let mapleader=" "

" Take care of the language settings: normal mode commands should be
" invoked with greek layout also.

set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz
set langremap

" ensure utf-8
set encoding=utf-8

syntax on

set hidden

set wildmode=longest,list,full

" This is how you set a colorscheme:
colorscheme codedark

" truecolors?
set termguicolors

" highlight cursor position
set cursorline
" set cursorcolumn

highlight CursorLine ctermbg=Yellow cterm=bold guibg=#202020
highlight LineNr guifg=#505050
highlight CursorLineNr guifg=#707070

" slpit below and right instead of above and left
set splitright splitbelow

" dont highlight search matches (or use underline maybe?)
set nohlsearch

" tabs width
set tabstop=2
set shiftwidth=2
	
" set numbers and see how it goes
set number relativenumber


" format text
map Q gq

" Window bindings
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader><leader> <C-w>w
 
noremap <leader>G :Goyo<CR>
noremap <leader>F :Files<CR>
noremap <leader>gv :edit $MYVIMRC<CR>

autocmd BufWritePost $MYVIMRC :source $MYVIMRC
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
autocmd BufWritePost *i3.conf,*i3blocks/config !i3-msg restart
