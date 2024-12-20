-- 文件: init.lua

-- 编码设置
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 显示设置
vim.opt.list = true
vim.opt.listchars = { tab = '┆ ' }
vim.opt.syntax = 'on'
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- 搜索设置
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 缩进设置
vim.opt.autoindent = false
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 显示设置
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 7
vim.opt.conceallevel = 0

-- 备份文件设置
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- vim.opt.swapfile = false

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
local opts = { noremap = true, silent = true }

-- 设置leader键
vim.g.mapleader = " "

-- 快速打开配置文件
local config_path = vim.fn.stdpath('config')
vim.keymap.set('n', 'init', string.format(':e %s/init.lua<CR>', config_path), opts)

-- 设置文件类型
vim.keymap.set('n', 'ft', ':set filetype=', opts)

-- 重新加载配置
vim.keymap.set('n', '<C-r>', ':source %<CR>', opts)

-- 快速滚动
vim.keymap.set('n', 'K', '5k', opts)
vim.keymap.set('n', 'J', '5j', opts)

-- 保存和退出
vim.keymap.set('n', 'W', ':w<CR>', opts)
vim.keymap.set('n', 'Q', ':q<CR>', opts)
vim.keymap.set('n', 'FQ', ':q!<CR>', opts)
vim.keymap.set('n', 'S', ':w ', opts)

-- 系统剪贴板
vim.keymap.set('v', 'Y', '"+y', opts)

-- 取消搜索高亮
vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>', opts)

-- 查找替换
vim.keymap.set('n', 'sg', ':%s//g<left><left>', opts)

-- 窗口管理
vim.keymap.set('n', 'sj', ':split<CR>', opts)
vim.keymap.set('n', 'sl', ':vsplit<CR>', opts)

-- 标签页管理
vim.keymap.set('n', 'tt', ':tabe<CR>', opts)
vim.keymap.set('n', 'th', ':-tabnext<CR>', opts)
vim.keymap.set('n', 'tl', ':+tabnext<CR>', opts)

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
vim.keymap.set('n', '<C-F>', ':Autoformat', opts)