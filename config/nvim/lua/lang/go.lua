-- lua/lang/go.lua
local lsp = require("lsp")

-- gopls with simple tweaks
lsp.setup_server("gopls", {
  settings = {
    gopls = {
      usePlaceholders = true,
      analyses = { unusedparams = true },
    },
  },
})

-- gofmt/goimports via LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go" },
  callback = function() pcall(vim.lsp.buf.format, { async = false }) end,
})
