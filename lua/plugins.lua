return {
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = "0.1.x",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = "make"
      }
    },
    config = function()
      local keymap = vim.api.nvim_set_keymap
      keymap("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { silent = true, noremap = true })

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            -- 検索から除外するものを指定
            "^.git/",
            "^.venv/",
            "^node_modules/",
          },
          vimgrep_arguments = {
            -- ripggrepコマンドのオプション
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "-uu",
          },
        },
        extensions = {
          -- ソート性能を大幅に向上させるfzfを使う
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("fzf")
    end
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
    "nvim-lualine/lualine.nvim",
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
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "yioneko/nvim-yati" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "yaml",
          "json",
          "css",
          "typescript",
          "javascript",
          "tsx",
          "vue",
          "dockerfile",
          "prisma",
          "python",
        },
        highlight = { enable = true, disable = { "markdown" } },
        autotag = { enable = true },
        indent = { enable = false },
        yati = { enable = true, disable = { "markdown" } },
      })
    end,
  },

  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        "coc-json",
        "coc-tsserver",
        "coc-yaml",
        "coc-prettier",
        "coc-prisma",
        "coc-pyright",
        "@yaegassy/coc-volar",
        "@yaegassy/coc-tailwindcss3"
      }

      local keymap = vim.api.nvim_set_keymap
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use F to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      keymap("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keymap("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
      keymap("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      keymap("n", "F", '<CMD>lua _G.show_docs()<CR>', {silent = true})
    end
  }
}
