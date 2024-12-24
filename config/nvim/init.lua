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
vim.opt.fillchars:append("eob: ")
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.scrolloff = 7
vim.opt.conceallevel = 0

-- 备份设置
vim.opt.undofile = false
vim.o.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- 键位映射
-- local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 设置leader键
vim.g.mapleader = " "

-- 快速打开配置文件
local config_path = vim.fn.stdpath("config")
vim.keymap.set("n", "init", string.format(":e %s/init.lua<CR>", config_path), opts)

-- 重新加载配置文件
vim.keymap.set("n", "<C-r>", ":source %<CR>", opts)

-- 设置文件类型
vim.keymap.set("n", "ft", ":set filetype=", opts)

vim.keymap.set("n", "ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "lg", ":Telescope live_grep<CR>", opts)

-- 快速滚动
vim.keymap.set("", "K", "5k", opts)
vim.keymap.set("", "J", "5j", opts)
vim.keymap.set("", "H", "b", opts)
vim.keymap.set("", "L", "w", opts)

-- 保存和退出
vim.keymap.set("n", "W", ":w<CR>", { silent = true })
vim.keymap.set("n", "Q", ":q<CR>", { silent = true })
vim.keymap.set("n", "FQ", ":q!<CR>", { silent = true })

-- 系统剪贴板
vim.keymap.set("v", "Y", '"+y', opts)

-- 取消搜索高亮
vim.keymap.set("n", "<leader><CR>", ":nohlsearch<CR>", { silent = true })

-- 查找替换
vim.keymap.set("n", "sg", ":%s//g<left><left>", { silent = false })

-- 窗口管理
vim.keymap.set("n", "<C-w>j", ":split<CR>", opts)
vim.keymap.set("n", "<C-w>l", ":vsplit<CR>", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)

-- 标签页管理
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", opts)
vim.keymap.set("n", "<C-n>", ":tabnext<CR>", opts)
vim.keymap.set("n", "<C-p>", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<C-w>", ":tabclose<CR>", opts)

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
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      -- indent = { enabled = true },
      dashboard = {
        -- your dashboard configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

        formats = {
          key = function(item)
            return {
              { "[", hl = "special" },
              { item.key, hl = "key" },
              { "]", hl = "special" },
            }
          end,
        },
        sections = {
          {
            section = "terminal",
            cmd = "fortune -s | cowsay",
            hl = "header",
            padding = 1,
            indent = 8,
          },
          { title = "MRU", padding = 1 },
          { section = "recent_files", limit = 8, padding = 1 },
          -- { title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          -- { section = "recent_files", cwd = true, limit = 8, padding = 1 },
          { title = "Sessions", padding = 1 },
          { section = "projects", padding = 1 },
          { title = "Bookmarks", padding = 1 },
          { section = "keys" },
        },
      },
    },
  },
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
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --   },
  -- },
  {
    {
      "justinsgithub/oh-my-monokai.nvim",
      lazy = false,
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
    lazy = true,
    config = function()
      require("telescope").setup({
        defaults = {},
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = true,
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "stevearc/conform.nvim",
    branch = "nvim-0.9",
    lazy = false,
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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = "VeryLazy",
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

      -- 启用预览窗口
      vim.cmd([[
        set updatetime=300
        set pumheight=20
        
        " 总是显示预览窗口
        set previewwindow
        
        " 配置弹出窗口
        call coc#config('suggest', {
              \ 'enablePreview': v:true,
              \ 'enablePreselect': v:false,
              \ 'noselect': v:true,
              \ 'floatConfig': {
              \   'border': v:true,
              \   'rounded': v:true
              \ }
              \})
      ]])

      -- Helper function to check backspace
      vim.api.nvim_exec(
        [[
        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
      ]],
        false
      )

      -- Tab: 如果补全菜单可见就选择当前项或切换到下一项，否则触发补全
      vim.keymap.set(
        "i",
        "<TAB>",
        [[coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()]],
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      -- Shift-Tab: 在补全菜单中向上切换
      vim.keymap.set(
        "i",
        "<S-TAB>",
        [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

      -- Space: 如果补全菜单可见就确认选择，否则输入空格
      vim.keymap.set(
        "i",
        "<space>",
        [[coc#pum#visible()  ?  coc#pum#confirm()  .  "\<space>"  :  "\<space>"]],
        { silent = true, noremap = true, expr = true, replace_keycodes = false }
      )

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
