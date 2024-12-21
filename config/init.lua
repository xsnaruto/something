
-- 编码设置
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- 显示设置
vim.opt.list = true
-- vim.opt.listchars = { tab = '┆ ' }
vim.opt.syntax = 'on'
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- 搜索设置
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 缩进设置
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- 显示设置
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.cursorline = true
vim.opt.scrolloff = 7
vim.opt.conceallevel = 0

vim.keymap.set("n", "<leader>p", function()
    vim.opt.paste = true
    vim.cmd("normal! \"*p") -- 粘贴剪贴板内容
    vim.opt.paste = false
end, { desc = "Paste without autoindent" })

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
-- vim.cmd([[
--     set t_Co=256
--     colorscheme molokai
--     let g:molokai_original = 1
--     let g:rehash256 = 1
-- ]])

-- 键位映射
-- local keymap = vim.keymap.set
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

-- 自动安装 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "rg",
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 推荐使用稳定分支
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 配置 lazy.nvim
require("lazy").setup({
  -- coc.nvim 的插件配置
  {
    {
       "justinsgithub/oh-my-monokai.nvim",
       config = function()
         require("oh-my-monokai").setup({
           transparent_background = true,
           palette = "default", "ristretto", "spectrum"
         })
         vim.cmd("colorscheme oh-my-monokai")
       end,
    }
  },
  {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
          require("telescope").setup({
              defaults = {
                  -- 配置选项，例如映射、窗口外观等
              },
          })
      end,
  },
  -- 可选的扩展插件
  {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
          require("telescope").load_extension("fzf")
      end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- coc.nvim 配置
      vim.g.coc_global_extensions = {
        "coc-marketplace", "coc-sh", "coc-html", "coc-css", "coc-tsserver", "coc-pyright", "coc-lua", "coc-yaml", "coc-json", "coc-xml"
      }

      vim.g.coc_settings = {
        ["Lua.diagnostics.globals"] = {"vim"}
      }

      -- 检查光标是否在行首或空白字符后
      function _G.check_backspace()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- 设置快捷键
      vim.api.nvim_set_keymap(
        "i", -- 插入模式
        "<TAB>",
        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_backspace() ? "<TAB>" : coc#refresh()',
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      vim.api.nvim_set_keymap(
        "i", -- 插入模式
        "<S-TAB>",
        'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"',
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      vim.api.nvim_set_keymap(
        "i", -- 插入模式
        "<CR>",
        'coc#pum#visible() ? coc#pum#confirm() : "<CR>"',
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      vim.api.nvim_set_keymap(
        "n", -- 普通模式
        "[g",
        "<Plug>(coc-diagnostic-prev)",
        { silent = true }
      )

      vim.api.nvim_set_keymap(
        "n", -- 普通模式
        "]g",
        "<Plug>(coc-diagnostic-next)",
        { silent = true }
      )

      vim.api.nvim_set_keymap(
        "n", -- 普通模式
        "gd",
        "<Plug>(coc-definition)",
        { silent = true }
      )

      vim.api.nvim_set_keymap(
        "n", -- 普通模式
        "gy",
        "<Plug>(coc-type-definition)",
        { silent = true }
      )

      vim.api.nvim_set_keymap(
        "n", -- 普通模式
        "gr",
        "<Plug>(coc-references)",
        { silent = true }
      )
    end,
  },
})

                        --
vim.opt.updatetime = 100

-- SuperTab配置
-- vim.g.SuperTabDefaultCompletionType = "<c-n>"

-- NERDTree配置
-- vim.keymap.set('n', 'fs', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 其他设置
-- IndentLine配置
-- vim.g.indentLine_defaultGroup = 'SpecialKey'

-- Prettier配置
-- vim.keymap.set('n', '<C-F>', ':Autoformat', opts)
