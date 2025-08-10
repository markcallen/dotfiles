-- lua/plugins/init.lua
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path })
  vim.cmd("packadd packer.nvim")
end

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- theme
  use 'navarasu/onedark.nvim'

  -- Core
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { 'nvim-tree/nvim-tree.lua', requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
end)

-- Treesitter config
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "typescript", "tsx", "go", "lua", "json", "bash", "yaml", "markdown" },
  highlight = { enable = true },
})
