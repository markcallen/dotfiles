-- lua/lsp/init.lua
local cmp = require("cmp")
local lspconfig = require("lspconfig")

-- nvim-cmp
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- shared capabilities + on_attach
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
  end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K",  vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
end

-- helper to setup a server
local M = {}
function M.setup_server(name, opts)
  opts = opts or {}
  opts.capabilities = vim.tbl_deep_extend("force", capabilities, opts.capabilities or {})
  opts.on_attach = opts.on_attach or on_attach
  lspconfig[name].setup(opts)
end

return M
