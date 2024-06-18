return {
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    keys = {
      { "s", "<CMD>HopWord<CR>", silent = true, noremap = true },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
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
    "nvim-neo-tree/neo-tree.nvim",
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
          hide_by_name = { "node_modules" },
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
    "lewis6991/gitsigns.nvim",
    lazy = false,
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
    "kdheepak/lazygit.nvim",
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
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<CMD>ToggleTerm<CR>", silent = true, noremap = true },
    },
    config = function()
      require("toggleterm").setup({
        direction = "float",
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
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = { "yioneko/nvim-yati" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "json",
          "yaml",
          "tsx",
          "typescript",
          -- "markdown",
        },
        auto_install = false,
        highlight = { enable = true },
        autotag = { enable = true },
        indent = { enable = false },
        yati = { enable = true, disable = { "markdown" } },
      })
    end,
  },

  {
    "neoclide/coc.nvim",
    lazy = false,
    branch = "release",
    config = function()
      -- 関数 CheckBackspace の定義
      function _G.CheckBackspace()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      vim.api.nvim_set_keymap('i', '<Tab>',
        [[coc#pum#visible() ? coc#pum#next(1) : v:lua.CheckBackspace() ? "<Tab>" : coc#refresh()]],
        { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"]],
        { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap('i', '<CR>',
        [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
        { noremap = true, silent = true, expr = true })
      vim.api.nvim_set_keymap("n", "F", '<CMD>lua _G.show_docs()<CR>', { silent = true })
    end,
  },
}
