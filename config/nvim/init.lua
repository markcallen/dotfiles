-- init.lua
require("core")      -- options, keymaps
require("plugins")   -- packer + plugin setup
require("lsp")       -- cmp + shared lsp defaults

-- language-specific LSP setup
require("lang.python")
require("lang.typescript")
require("lang.go")

-- utils
require("utils.nvim-tree")
