require("config.keymaps")
require("config.lazyvim")
require("config.options")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.b.coc_root_patterns = { '.venv' }
  end
})
