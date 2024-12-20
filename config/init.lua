-- Basic settings
vim.opt.encoding = 'utf-8'                -- 设置编码为 UTF-8
vim.opt.termencoding = 'utf-8'            -- 设置终端编码为 UTF-8
vim.opt.fileencoding = 'utf-8'           -- 设置文件编码为 UTF-8

vim.opt.list = true                       -- 显示制表符和空格
vim.opt.listchars = { tab = '┆' }         -- 使用竖线表示 TAB 键

vim.cmd('syntax on')                      -- 启用语法高亮

vim.opt.ignorecase = true                 -- 忽略搜索时的大小写
vim.opt.smartcase = true                  -- 当搜索包含大写字母时，区分大小写

vim.opt.conceallevel = 0                 -- 禁止字符自动隐藏，如双引号

-- 缩进设置
vim.opt.autoindent = false                -- 关闭自动缩进
vim.opt.smartindent = true                -- 启用智能缩进
vim.opt.tabstop = 4                      -- 一个 TAB 键相当于 4 个空格
vim.opt.softtabstop = 4                  -- 插入 TAB 时缩进的宽度
vim.opt.shiftwidth = 4                   -- 向后移动时的缩进宽度
vim.opt.expandtab = true                 -- 使用空格代替 TAB

-- 行号设置
vim.opt.number = true                     -- 显示行号
vim.opt.relativenumber = false           -- 关闭相对行号
vim.opt.cursorline = true                -- 高亮当前行

vim.opt.scrolloff = 7                    -- 设置滚动时的空余行数

-- Backup/Swap File settings
vim.cmd([[
augroup AutoDeleteSwapOnWrite
  autocmd!
  -- 在执行保存命令后删除 swap 文件
  autocmd BufWritePost * if exists("v:swapname") | call delete(v:swapname) | let v:swapname = '' | endif
augroup END
]])

-- 配色设置
vim.opt.background = 'dark'              -- 设置背景为深色
vim.opt.termguicolors = true             -- 支持更丰富的 256 色显示
vim.cmd('colo molokai')                 -- 设置配色方案为 molokai
vim.g.molokai_original = 1               -- 保持原始 molokai 配色
vim.g.rehash256 = 1                     -- 强制重新加载 256 色

-- Hotkey settings
vim.g.mapleader = ' '                    -- 设置 Leader 键为空格
vim.api.nvim_set_keymap('n', '<Leader>init', ':e ~/.config/nvim/init.vim<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ft', ':set filetype=', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-r>', ':source %<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', '5k', { noremap = true })    -- 快速上滚 5 行
vim.api.nvim_set_keymap('n', 'J', '5j', { noremap = true })    -- 快速下滚 5 行
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', { noremap = true }) -- 快速保存
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', { noremap = true }) -- 快速退出
vim.api.nvim_set_keymap('n', '<Leader><CR>', ':nohlsearch<CR>', { noremap = true }) -- 取消搜索高亮
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true })   -- 复制到系统剪切板
vim.api.nvim_set_keymap('n', '<Leader>sg', ':%s//g<left><left>', { noremap = true }) -- 快速替换

-- Windows manage
vim.api.nvim_set_keymap('n', 'sj', ':split<CR>', { noremap = true })    -- 水平分割窗口
vim.api.nvim_set_keymap('n', 'sl', ':vsplit<CR>', { noremap = true })   -- 垂直分割窗口

-- Tag manage
vim.api.nvim_set_keymap('n', 'tt', ':tabe<CR>', { noremap = true })  -- 新增标签页
vim.api.nvim_set_keymap('n', 'th', ':-tabnext<CR>', { noremap = true }) -- 关闭左侧标签页
vim.api.nvim_set_keymap('n', 'tl', ':+tabnext<CR>', { noremap = true }) -- 关闭右侧标签页

-- Plugins manage
vim.cmd([[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  :exe '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'                -- Vim 状态栏插件
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } -- 语法高亮增强
Plug 'neoclide/coc.nvim', { 'branch': 'release' } -- 补全插件
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' } -- 左侧滚动查看
Plug 'mbbill/undotree'                        -- Undo 代码历史
Plug 'Yggdroot/indentLine'                    -- 可视化缩进线
Plug 'preservim/nerdtree', { 'tag': '7.1.2' } -- 文件树
Plug 'jlanzarotta/bufexplorer', { 'commit': '20f0440' } -- 文件历史管理
Plug 'github/copilot.vim'                     -- GitHub Copilot
call plug#end()
]])

-- Coc.vim settings
vim.opt.updatetime = 100                     -- 设置自动更新时间间隔为 100ms
vim.g.coc_global_extensions = {              -- 默认全局扩展
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

-- NerdTree manage
vim.api.nvim_set_keymap('n', 'fs', ':NERDTreeToggle<CR>', { noremap = true }) -- 开/关 NERDTree

-- Other settings
vim.api.nvim_set_keymap('n', '<C-F>', ':Autoformat', { noremap = true }) -- 格式化文件