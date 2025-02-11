-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {"c", "lua", "vim"},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
--  "wellle/context.vim",
  "mhinz/vim-signify",
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "topline",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      }
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("lualine").setup { options = {theme = 'kanagawa_paper'} }
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      vim.cmd [[
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        nnoremap <leader>ft <cmd>TodoTelescope<cr>
        nnoremap <leader>td <cmd>TodoTelescope<cr>
        " TODO: This should be store din the trouble.nvim config but it doesn't
        " seem to invoke the config function.
        nnoremap <leader>td <cmd>TodoTrouble<cr>
        nnoremap <leader>tt <cmd>Trouble diagnostics toggle filter.buf=0<cr>
      ]]
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },
  {
    "ms-jpq/coq_nvim",
    config = function()
      vim.cmd [[
        COQnow
      ]]
    end
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          cpp = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 200,
          lsp_format = "fallback",
        },
      }
    end
  },
  -- Theme
  {
    "sho-87/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd [[
        colorscheme kanagawa-paper
      ]]
    end
  }
})
