-- 编码设置
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 显示设置
vim.opt.list = false
vim.opt.listchars = { tab = "┆ " }
vim.opt.syntax = "on"
vim.opt.background = "dark"
vim.opt.termguicolors = true
-- 使用 Hack 字体设置 Neovim

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
vim.opt.relativenumber = false
-- vim.opt.cursorline = true
vim.opt.scrolloff = 7
vim.opt.conceallevel = 0

vim.keymap.set("n", "<leader>p", function()
  vim.opt.paste = true
  vim.cmd('normal! "*p') -- 粘贴剪贴板内容
  vim.opt.paste = false
end, { desc = "Paste without autoindent" })

-- 备份文件设置
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- -- 自动删除swap文件
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     if vim.v.swapname ~= "" then
--       os.remove(vim.v.swapname)
--       vim.v.swapname = ""
--     end
--   end,
-- })

-- 键位映射
-- local keymap = vim.keymap.set
local opts = { noremap = true, silent = false }

-- 设置leader键
vim.g.mapleader = " "

-- 快速打开配置文件
local config_path = vim.fn.stdpath("config")
vim.keymap.set("n", "init", string.format(":e %s/init.lua<CR>", config_path), opts)

-- 设置文件类型
vim.keymap.set("n", "ft", ":set filetype=", opts)

vim.keymap.set("n", "ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "lg", ":Telescope live_grep<CR>", opts)

-- 重新加载配置
vim.keymap.set("n", "<C-r>", ":source %<CR>", opts)

-- 快速滚动
vim.keymap.set("n", "K", "5k", opts)
vim.keymap.set("n", "J", "5j", opts)

-- 保存和退出
vim.keymap.set("n", "W", ":w<CR>", { silent = true })
vim.keymap.set("n", "Q", ":q<CR>", { silent = true })
vim.keymap.set("n", "FQ", ":q!<CR>", { silent = true })

-- 系统剪贴板
vim.keymap.set("v", "Y", '"+y', opts)

-- 取消搜索高亮
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { silent = true })

-- 查找替换
vim.keymap.set("n", "sg", ":%s//g<left><left>", opts)

-- 窗口管理
vim.keymap.set("n", "sj", ":split<CR>", opts)
vim.keymap.set("n", "sl", ":vsplit<CR>", opts)

-- 标签页管理
vim.keymap.set("n", "tt", ":tabe<CR>", opts)
vim.keymap.set("n", "th", ":-tabnext<CR>", opts)
vim.keymap.set("n", "tl", ":+tabnext<CR>", opts)

-- 自动安装 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
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
    "vim-airline/vim-airline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- {
  --   "adelarsq/neoline.vim",
  -- },
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' }
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- {
  --     "nvim-neo-tree/neo-tree.nvim",
  --     branch = "v3.x",
  --     dependencies = {
  --         "nvim-lua/plenary.nvim",
  --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --         "MunifTanjim/nui.nvim"
  --         -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --     }
  -- },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
  },
  {
    {
      "justinsgithub/oh-my-monokai.nvim",
      config = function()
        require("oh-my-monokai").setup({
          transparent_background = true,
          palette = "default",
          "ristretto",
          "spectrum",
        })
        vim.cmd("colorscheme oh-my-monokai")
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {},
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      -- Conform 配置
      require("conform").setup({
        -- 为不同文件类型设置格式化工具
        formatters_by_ft = {
          html = { "prettier" },
          css = { "prettier" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          markdown = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          xml = { "xmllint" },
          lua = { "stylua" },
          ruby = { "rubocop" },

          gitignore = { "prettier" },
          editorconfig = { "prettier" },

          nginx = { "nginxfmt" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          python = { "black", "isort" },
          go = { "gofmt" },
          php = { "phpcbf" },
          java = { "clang_format" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          objc = { "clang_format" },
          rust = { "rustfmt" },
          swift = { "swiftformat" },
          kotlin = { "ktlint" },
        },
        formatters = {
          prettier = {
            prepend_args = {
              "--indent-type",
              "Spaces",
              "--indent-width",
              "2",
            },
          },
          stylua = {
            prepend_args = {
              "--indent-type",
              "Spaces",
              "--indent-width",
              "2",
            },
          },
        },
      })

      -- 添加快捷键手动触发格式化
      vim.keymap.set("n", "<C-F>", function()
        require("conform").format({ async = true }) -- 异步格式化
      end, { desc = "Format current buffer with Conform" })
    end,
  },
  -- {
  --     "github/copilot.vim"
  -- },
  -- {
  --     "vim-autoformat/vim-autoformat"
  -- },
{
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "stylua", "prettier" },
    })
  end
},
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- coc.nvim 配置
      vim.g.coc_global_extensions = {
        "coc-marketplace",
        "coc-explorer",
        "coc-git",
        "coc-sh",
        "coc-html",
        "coc-css",
        "coc-tsserver",
        "coc-pyright",
        "coc-lua",
        "coc-yaml",
        "coc-json",
        "coc-xml",
      }

      vim.fn["coc#config"]("Lua.diagnostics.globals", { "vim" })
      vim.fn["coc#config"]("suggest.noselect", { true })

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
        "<C-space>",
        'coc#pum#visible() ? coc#pum#confirm() : "<CR>"',
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      -- Use `[g` and `]g` to navigate diagnostics
      vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- GoTo code navigation
      vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
      vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
      vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
      vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

    end,
  },
})

--
vim.opt.updatetime = 100

-- SuperTab配置
-- vim.g.SuperTabDefaultCompletionType = "<c-n>"

-- NeoTree配置
-- vim.keymap.set('n', 'fs', ':Neotree<CR>', opts)

-- NERDTree配置
-- vim.keymap.set('n', 'fs', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- 其他设置
-- IndentLine配置
-- vim.g.indentLine_defaultGroup = 'SpecialKey'

-- prettier配置
-- vim.keymap.set("n", "<C-F>", ":Autoformat", opts)
