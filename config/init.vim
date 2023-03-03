set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
syntax enable
"set number
set scrolloff=5
set noswapfile

set background=dark
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

map K 5k
map J 5j
 
map W :w<CR>
map Q :q<CR>


call plug#begin('~/.config/nvim/plugged') 
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neoclide/coc.nvim'
"Plug 'mhinz/vim-startify'
"Plug 'glepnir/dashboard-nvim'
"Plug 'glepnir/spaceline.vim'
"Plug 'ryanoasis/vim-devicons'
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'
"Plug 'kyazdani42/nvim-web-devicons'
"Plug 'wakatime/vim-wakatime'
call plug#end() 

nnoremap <space>e :CocCommand explorer<CR>
