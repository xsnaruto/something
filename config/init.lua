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

-- 插件管理 (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件配置
require("lazy").setup({
    -- UI 增强
    {
        "vim-airline/vim-airline",
        event = "VeryLazy",
    },
    
    -- 语法高亮
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    
    -- LSP 支持
    {
        "neoclide/coc.nvim",
        branch = "release",
        event = { "BufReadPre", "BufNewFile" },
    },
    
    -- 滚动条
    {
        "dstein64/nvim-scrollview",
        event = "VeryLazy",
    },
    
    -- 撤销树
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
    },
    
    -- 缩进线
    {
        "Yggdroot/indentLine",
        event = { "BufReadPost", "BufNewFile" },
    },
    
    -- Bash 支持
    {
        "WolfgangMehner/bash-support",
        commit = "99c746c",
        ft = "sh",
    },
    
    -- 文件树
    {
        "preservim/nerdtree",
        version = "7.1.2",
        cmd = "NERDTreeToggle",
    },
    
    -- 缓冲区管理
    {
        "jlanzarotta/bufexplorer",
        commit = "20f0440",
        cmd = "BufExplorer",
    },
    
    -- GitHub Copilot
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },
})

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