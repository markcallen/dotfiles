-- lua/lang/typescript.lua
local lsp = require("lsp")

-- ts_ls (new name replacing tsserver)
lsp.setup_server("ts_ls", {
  init_options = { hostInfo = "neovim" },
})

-- TS/TSX/JS formatting-on-save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    pcall(vim.lsp.buf.format, { async = false })
  end,
})
