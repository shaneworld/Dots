-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
    priority = 1000,
    config = function()
      require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          transparent_background = true,
      })

      -- setup must be called before loading
      vim.cmd.colorscheme "catppuccin"
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
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
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
        disable_filetype = { "TelescopePrompt" , "vim" },
      }
  },

  {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { "markdown" },
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
  },

  {
      "catgoose/nvim-colorizer.lua",
      event = "BufReadPre",
      opts = { -- set to setup table
      },
  }

})
