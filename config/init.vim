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

" 使用竖线来更改 TAB 制表符锁进
set list lcs=tab:\┆\ 

" 代码语法检测
syntax on

" 忽略大小写
set ignorecase smartcase

" 禁止雙引號自動隱藏
:set conceallevel=0

" 縮進相關設置
set autoindent			" 自动缩进
set smartindent			" 智能缩进
set tabstop=4			" 设置tab制表符号所占宽度为4
set softtabstop=4		" 设置按tab时缩进宽度为4
set shiftwidth=4		" 设置自动缩进宽度为4
" set expandtab			" 缩进时将tab制表服转为空格

" 行号配置
set number
set norelativenumber

" 保持编辑行的上下留出空余行数
set scrolloff=7

" 配色设置
set background=dark
set t_Co=256
colo molokai
let g:molokai_original = 1
let g:rehash256 = 1

"======================================
"           Hotkey settings
"======================================
" map space as <LEADER>
let mapleader=" "
" Fast open init.vim
noremap init :e ~/.config/nvim/init.vim<CR>
" Set filetype
noremap ft :set filetype=
" Reload init.vim
map <C-r> :source %<CR>
" Fast scroll line
map K 5k
map J 5j
" Fast Save & Quit 
map W :w<CR>
map Q :q<CR>
map FQ :q!<CR>
" Save to another path
noremap S :w 
" Copy to system clipboard
vnoremap Y "+y
" Disable search hightlight
noremap <LEADER><CR> :nohlsearch<CR>
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
" 检测 Vim-Plug 是否安装
if empty(glob('~/.config/nvim/autoload/plug.vim')) 
  :exe '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 插件管理
call plug#begin('~/.config/nvim/plugged')
"Plug 'hardcoreplayers/dashboard-nvim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ervandew/supertab'
" Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'vim-autoformat/vim-autoformat'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
call plug#end()
"
"======================================
"           Coc.vim settings
"======================================
" 加载更新时间
set updatetime=100
" 加载 Coc 插件
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-css',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-syntax',
	\ 'coc-vimlsp',
	\ 'coc-yaml']
" 补全提示切换方向从上往下
let g:SuperTabDefaultCompletionType = "<c-n>"

"======================================
"           NerdTree manage
"======================================
map fs :NERDTreeToggle<CR>
"
"======================================
"           Other settings
"======================================
" 对齐标准线和可视化缩进
" let g:indentLine_defaultGroup = 'SpecialKey'
" Prettier 快捷操作
noremap <C-F> :Autoformat
