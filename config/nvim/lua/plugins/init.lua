return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

--  {
--    "christoomey/vim-tmux-navigator",
--    keys = {
--      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
--      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
--      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
--      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
--      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
--    },
--    lazy = false,
--  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

 {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  		 "vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {},
    config = true,
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } }  },
    keys = {
      {
        "<leader>oa",
        function() require("opencode").ask("@this: ", { submit = true }) end,
        desc = "Ask opencode",
        mode = { "n", "x" }
      },
      {
        "<leader>oo",
        function() require("opencode").toggle() end,
        desc = "Toggle opencode",
        mode = { "n", "t" }
      },
      {
        "<leader>oa",
        function() return require("opencode").operator("@this ") end,
        desc = "Add range to opencode",
        mode = { "n", "x" },
        expr = true
      },
      {
        "<leader>ol",
        function() return require("opencode").operator("@this ") .. "_" end,
        desc = "Add line to opencode",
        mode = { "n" },
        expr = true
      }
    }
  }
}
