-- 文件: init.lua

-- 基础设置
local opt = vim.opt

-- 编码设置
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- 显示设置
opt.list = true
opt.listchars = { tab = '┆ ' }
opt.syntax = 'on'
opt.background = 'dark'
opt.termguicolors = true

-- 搜索设置
opt.ignorecase = true
opt.smartcase = true

-- 缩进设置
opt.autoindent = false
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- 显示设置
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.scrolloff = 7
opt.conceallevel = 0

-- 备份文件设置
-- opt.backup = false
-- opt.writebackup = false
-- opt.swapfile = false

-- 自动删除swap文件
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
        if vim.v.swapname ~= '' then
            os.remove(vim.v.swapname)
            vim.v.swapname = ''
        end
    end
})

-- 配色设置
vim.cmd([[
    set t_Co=256
    colorscheme molokai
    let g:molokai_original = 1
    let g:rehash256 = 1
]])

-- 键位映射
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 设置leader键
vim.g.mapleader = " "

-- 快速打开配置文件
local config_path = vim.fn.stdpath('config')
keymap('n', 'init', string.format(':e %s/init.lua<CR>', config_path), opts)

-- 设置文件类型
keymap('n', 'ft', ':set filetype=', opts)

-- 重新加载配置
keymap('n', '<C-r>', ':source %<CR>', opts)

-- 快速滚动
keymap('n', 'K', '5k', opts)
keymap('n', 'J', '5j', opts)

-- 保存和退出
keymap('n', 'W', ':w<CR>', opts)
keymap('n', 'Q', ':q<CR>', opts)
keymap('n', 'FQ', ':q!<CR>', opts)
keymap('n', 'S', ':w ', opts)

-- 系统剪贴板
keymap('v', 'Y', '"+y', opts)

-- 取消搜索高亮
keymap('n', '<leader><CR>', ':nohlsearch<CR>', opts)

-- 查找替换
keymap('n', 'sg', ':%s//g<left><left>', opts)

-- 窗口管理
keymap('n', 'sj', ':split<CR>', opts)
keymap('n', 'sl', ':vsplit<CR>', opts)

-- 标签页管理
keymap('n', 'tt', ':tabe<CR>', opts)
keymap('n', 'th', ':-tabnext<CR>', opts)
keymap('n', 'tl', ':+tabnext<CR>', opts)

-- vim-plug 自动安装
local install_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        'curl', '-fLo', install_path, '--create-dirs',
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    })
end

-- 插件安装
vim.cmd([[
call plug#begin()
" UI 增强
" Plug 'hardcoreplayers/dashboard-nvim'
" Plug 'vim-airline/vim-airline'

" 语法高亮
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP 支持
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 其他插件
" Plug 'ervandew/supertab'
" Plug 'prettier/vim-prettier', { 'do': 'npm install' }
" Plug 'vim-autoformat/vim-autoformat'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'mbbill/undotree'
Plug 'Yggdroot/indentLine'
Plug 'WolfgangMehner/bash-support', { 'commit': '99c746c' }
Plug 'preservim/nerdtree', { 'tag': '7.1.2' }
Plug 'jlanzarotta/bufexplorer', { 'commit': '20f0440' }
Plug 'github/copilot.vim'
call plug#end()

" 自动安装插件
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
]])

-- Coc配置
vim.g.coc_global_extensions = {
    'coc-marketplace',
    'coc-explorer',
    'coc-sh',
    'coc-html',
    'coc-css',
    'coc-tsserver',
    'coc-python',
    'coc-json',
    'coc-yaml',
    'coc-prettier'
}

vim.opt.updatetime = 100

-- SuperTab配置
vim.g.SuperTabDefaultCompletionType = "<c-n>"

-- NERDTree配置
vim.keymap.set('n', 'fs', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 其他设置
-- IndentLine配置
-- vim.g.indentLine_defaultGroup = 'SpecialKey'

-- Prettier配置
keymap('n', '<C-F>', ':Autoformat', opts)