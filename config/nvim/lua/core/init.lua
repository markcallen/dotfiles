-- lua/core/init.lua
local o, g = vim.opt, vim.g

o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.termguicolors = true
o.clipboard = "unnamedplus"
o.updatetime = 300
o.signcolumn = "yes"

-- leader
g.mapleader = "\\"

-- telescope keys (lazy-safe: will work once loaded)
local map = vim.keymap.set
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end)
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)
