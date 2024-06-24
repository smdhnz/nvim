return {
	{
		"numToStr/Comment.nvim",
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
				},
				highlight = { enable = true },
				autotag = { enable = true },
				indent = { enable = false },
				yati = { enable = true, disable = { "markdown" } },
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				python = { "isort", "black" },
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
				quiet = false,
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"onsails/lspkind.nvim",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			cmp.setup({
				window = {
					completion = cmp.config.window.bordered({
						border = "rounded",
					}),
					documentation = cmp.config.window.bordered({
						border = "rounded",
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "path" },
				}, {
					{ name = "buffer", keyword_length = 2 },
				}),
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.cmd("let g:vsnip_filetypes = {}")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- @vue/language-server
			lspconfig.volar.setup({
				init_options = {
					vue = { hybridMode = false },
				},
				filetypes = { "typescript", "javascript", "vue" },
			})

			-- typescript typescript-language-server
			lspconfig.tsserver.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
			})

			-- @tailwindcss/language-server
			lspconfig.tailwindcss.setup({})

			-- jedi-language-server
			lspconfig.jedi_language_server.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(_)
					vim.keymap.set("n", "F", "<cmd>lua vim.lsp.buf.hover()<CR>")
					vim.keymap.set("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>")
					vim.keymap.set("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
					vim.keymap.set("n", "f", "<cmd>lua vim.diagnostic.open_float()<CR>")
				end,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.diagnostic.config({ float = { border = "rounded" } })

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end,
	},
}
