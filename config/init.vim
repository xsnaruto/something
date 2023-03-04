" 
"  __  __        __     _____ __  __    ____             __ _       
" |  \/  |_   _  \ \   / /_ _|  \/  |  / ___|___  _ __  / _(_) __ _ 
" | |\/| | | | |  \ \ / / | || |\/| | | |   / _ \| '_ \| |_| |/ _` |
" | |  | | |_| |   \ V /  | || |  | | | |__| (_) | | | |  _| | (_| |
" |_|  |_|\__, |    \_/  |___|_|  |_|  \____\___/|_| |_|_| |_|\__, |
"         |___/                                               |___/ 
" 
"
"======================================
"           Basic settings
"======================================
" 文档编码
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Vim build-in 代码高亮
syntax enable

" 忽略大小写
set ignorecase

" 行号配置
set number
set norelativenumber

" 保持编辑行的上下留出空余行数
set scrolloff=5

" 配色设置
set background=dark
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

"======================================
"           Hotkey settings
"======================================
" map space as <SPACE>
let mapspace=" "
" Fast open init.vim
noremap init :e ~/.config/nvim/init.vim<CR>
" Reload init.vim
map <C-r> :source %<CR>
" Fast scroll line
map K 5k
map J 5j
" Fast Save & Quit 
map W :w<CR>
map Q :q<CR>
" Save to another path
noremap S :w 
" Copy to system clipboard
vnoremap Y "+y
" Disable search hightlight
noremap <SPACE>><CR> :nohlsearch<CR>
" Fast call full find and replace
noremap sg :%s//g<left><left>

"======================================
"           Windows manage
"======================================
" Add new window below or right
noremap sj :split<CR>
noremap sl :vsplit<CR>

"======================================
"           Tag manage
"======================================
" Add new tag
noremap tt :tabe<CR>
" Move to next tag
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

"======================================
"           Plugins manage
"======================================
call plug#begin('~/.config/nvim/plugged')
"Plug 'hardcoreplayers/dashboard-nvim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
call plug#end()
"
"======================================
"           Coc.vim settings
"======================================
" 加载 Coc 插件
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-css',
	\ 'coc-docker',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-syntax',
	\ 'coc-translator',
	\ 'coc-tsserver',
	\ 'coc-vimlsp',
	\ 'coc-yaml']
" 使用 TAB 取用补全
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

"======================================
"           NerdTree manage
"======================================
map fs :NERDTreeToggle<CR>
