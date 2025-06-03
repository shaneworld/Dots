-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({

  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",   -- latte, frappe, macchiato, mocha
        transparent_background = true,
      })

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim"
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cd",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'palenight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        }
      }
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css", "python", "java", "c"
      },
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    }
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {   -- set to setup table
    },
  },

  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
      },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = {
        documentation = { auto_show = true },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },

    opts_extend = { "sources.default" }
  },

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
  },

})
