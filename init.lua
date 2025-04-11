-- ====================
-- Leader キーの設定
-- ====================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ====================
-- Neovim オプション
-- ====================
local g = vim.g
local opt = vim.opt

-- 表示関連
opt.number = true
opt.relativenumber = false
opt.list = true
opt.showmode = false
opt.showtabline = 0
vim.o.signcolumn = "yes"
opt.cmdheight = 0
opt.laststatus = 3

-- 検索関連
opt.smartcase = true
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true

-- インデント関連
opt.autoindent = true
opt.smartindent = false
opt.expandtab = true
opt.smarttab = false
opt.shiftwidth = 2
opt.tabstop = 2

-- 見た目関連
opt.termguicolors = true
opt.wrap = false
opt.fillchars = { eob = " " }
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.conceallevel = 3

-- ファイル関連
opt.swapfile = false
opt.undofile = true
opt.lazyredraw = true
opt.autowrite = true
opt.splitkeep = "screen"

-- タイムアウト関連
opt.timeout = true
opt.timeoutlen = 500

-- その他
opt.splitbelow = true
opt.mouse = "a"
opt.foldenable = false
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.confirm = true
opt.completeopt = "menu,menuone,noselect,noinsert"

-- 不要なプラグイン無効化
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_tar = 1
g.loaded_vimball = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.matchup_matchparen_offscreen = { method = "status_manual " }

-- ====================
-- キーマップ定義
-- ====================
local map = vim.api.nvim_set_keymap

-- カーソル移動
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "J", "10j", { silent = true })
map("n", "K", "10k", { silent = true })
map("n", "G", "Gzz", { silent = true })

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- 検索
map("n", "<esc><esc>", "<cmd>nohlsearch<cr>", { silent = true })
map("n", "<leader><leader>", "<CMD>let @/ = '\\<' . expand('<cword>') . '\\>'<CR><CMD>set hlsearch<CR>", { silent = true })
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })

-- 貼り付け・やり直し
map("n", "p", "]p", { silent = true })
map("n", "P", "]P", { silent = true })
map("n", "U", "<C-r>", { silent = true })

-- 行移動
map("n", "H", "^", { silent = true })
map("x", "H", "^", { silent = true })
map("n", "L", "$", { silent = true })
map("x", "L", "$", { silent = true })

-- 日付挿入
map("n", "<F3>", '<ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR><ESC>', { silent = true })
map("i", "<F3>", '<C-R>=strftime("%Y/%m/%d")<CR>', { silent = true })

-- :s を %s///g に変換
vim.cmd([[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ":s" ? "%s///g<Left><Left>" : "s"]])

-- ====================
-- Lazy.nvim 初期化
-- ====================
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

-- ====================
-- プラグイン設定
-- ====================
require("lazy").setup({
  -- plugins 一覧
  {
    -- コメントトグル
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    -- Telescope (ファジー検索)
    'nvim-telescope/telescope.nvim',
    branch = "0.1.x",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" }
    },
    config = function()
      local keymap = vim.api.nvim_set_keymap
      keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { silent = true, noremap = true })

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "^.git/", "^.venv/", "^node_modules/" },
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "-uu",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  {
    -- Hop (高速移動)
    "phaazon/hop.nvim",
    branch = "v2",
    keys = {
      { "s", "<CMD>HopWord<CR>", silent = true, noremap = true },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },
  {
    -- テーマ: TokyoNight
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        hide_inactive_statusline = true,
        dim_inactive = false,
        lualine_bold = true,
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    -- ファイルツリー Neo-tree
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "e", "<CMD>Neotree<CR>", silent = true, noremap = true },
    },
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      popup_border_style = "rounded",
      window = {
        position = "float",
        mappings = {
          ["<space>"] = { "toggle_node", nowait = false },
          ["a"] = { "add", config = { show_path = "relative" } },
          ["d"] = "delete",
          ["m"] = "move",
          ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["e"] = "close_window",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          hide_by_name = { "node_modules", "__pycache__" },
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ["."] = "toggle_hidden",
            ["u"] = "navigate_up",
            ["o"] = "set_root",
          },
        },
      },
    },
  },
  {
    -- Git インジケーター
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      numhl = true,
      linehl = true,
    },
  },
  {
    -- LazyGit
    "kdheepak/lazygit.nvim",
    lazy = true,
    keys = {
      { "q", "<CMD>LazyGit<CR>", silent = true, noremap = true },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1
      vim.g.lazygit_floating_window_border_chars = { "", "", "", "", "", "", "", "" }
    end,
  },
  {
    -- ステータスライン
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    -- ターミナル統合
    "akinsho/toggleterm.nvim",
    lazy = true,
    version = "*",
    keys = {
      { "<C-\\>", "<CMD>ToggleTerm<CR>", silent = true, noremap = true },
    },
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })

      vim.api.nvim_create_autocmd({ "TermEnter" }, {
        pattern = { "term://*toggleterm#*" },
        callback = function()
          vim.api.nvim_set_keymap("t", "<C-\\>", '<CMD>exe v:count1 . "ToggleTerm"<CR>', { silent = true })
        end,
      })
    end,
  },
  {
    -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "yioneko/nvim-yati" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "yaml", "json", "css", "typescript", "javascript",
          "tsx", "vue", "dockerfile", "prisma", "python",
        },
        highlight = { enable = true, disable = { "markdown" } },
        autotag = { enable = true },
        indent = { enable = false },
        yati = { enable = true, disable = { "markdown" } },
      })
    end,
  },
  {
    -- Mason（LSP/DAP/formatter installer）
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true
  },
  {
    -- Masonとlspconfig連携
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls" },
      })
    end,
  },
  {
    -- LSP設定
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- 共通on_attach（フォーマット等）
      local on_attach = function(client, bufnr)
        local buf_map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
        end
        buf_map("n", "F", vim.lsp.buf.hover)
      end

      -- Pyright
      lspconfig.pyright.setup({
        on_attach = on_attach,
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(".venv", ".git")(fname)
        end,
      })

      -- TypeScript
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
      })
    end
  },
  {
    -- cmp補完
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<TAB>"] = cmp.mapping.select_next_item(),
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    -- none-ls: フォーマッタ/リンタ統合
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      local lsp_format_on_save = function(bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function(client)
                return client.name == "null-ls"
              end,
            })
          end,
        })
      end

      null_ls.setup({
        sources = {
          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          -- TypeScript
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "typescript", "typescriptreact", "json", "css", "html", "yaml", "markdown" }
          }),
        },
        on_attach = function(client, bufnr)
          if client.name == "null-ls" then
            lsp_format_on_save(bufnr)
          end
        end,
      })
    end,
  }
})

