vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap

-- expr = 式
-- silent = コマンド非表示
-- noremap = そのキーの本来の機能を呼び出す

-- move
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("x", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("x", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "J", "10j", { silent = true })
map("n", "K", "10k", { silent = true })
map("n", "G", "Gzz", { silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", noremap = true, silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", noremap = true, silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", noremap = true, silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", noremap = true, silent = true })

-- search
map("n", "<esc><esc>", "<cmd>nohlsearch<cr>", { desc = "Escape and clear hlsearch", silent = true })
map(
  "n",
  "<leader><leader>",
  "<CMD>let @/ = '\\<' . expand('<cword>') . '\\>'<CR><CMD>set hlsearch<CR>",
  { desc = "Highlight", silent = true }
)
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })

-- paste
map("n", "p", "]p", { silent = true })
map("n", "P", "]P", { silent = true })

-- redo
map("n", "U", "<C-r>", { silent = true })

-- jump right left
map("n", "H", "^", { noremap = true, silent = true })
map("x", "H", "^", { noremap = true, silent = true })
map("n", "L", "$", { noremap = true, silent = true })
map("x", "L", "$", { noremap = true, silent = true })

-- insert date
map("n", "<F3>", '<ESC>i<C-R>=strftime("%Y/%m/%d")<CR><CR><ESC>', { silent = true })
map("i", "<F3>", '<C-R>=strftime("%Y/%m/%d")<CR>', { silent = true })

-- replace :s
vim.cmd([[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ":s" ? "%s///g<Left><Left>" : "s"]])
