-- lua/lang/python.lua
local lsp = require("lsp")

-- Pyright: great defaults
lsp.setup_server("pyright")

-- Optional: format on save via LSP if server supports it
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py" },
  callback = function() pcall(vim.lsp.buf.format, { async = false }) end,
})
