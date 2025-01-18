local opts = { noremap = true, silent = true }
local autocmd = vim.api.nvim_create_autocmd

-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-- options
vim.opt.scrolloff = 5
vim.opt.wrap = true
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.undofile = true

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.showmode = false

-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- colors
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- mappings
-- normal mode
vim.keymap.set('n', 'H', '^', opts)
vim.keymap.set('n', 'L', '$', opts)
vim.keymap.set('n', '<Esc>', ':nohl<CR>', opts)
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bd<CR>', opts)
vim.keymap.set('n', ';', ':', opts)

-- insert mode
vim.keymap.set('i', 'jj', '<Esc>', opts)

-- visual mode
vim.keymap.set('v', 'H', '^', opts)
vim.keymap.set('v', 'L', '$', opts)

-- packages
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

-- Setup lazy.nvim
require("lazy").setup({
  -- theme
  {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
	  require("catppuccin").setup({
		  flavour = "mocha", -- latte, frappe, macchiato, mocha
		  transparent_background = true, -- disables setting the background color.
	  })
	  -- setup must be called before loading
	  vim.cmd.colorscheme "catppuccin"
	end
  },

  {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	config = function()
	  require("lualine").setup({})
	end
  },

  -- tabline
  {
	'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
	  auto_hide = true,
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },

  -- colorful delimiters
  {
	"hiphish/rainbow-delimiters.nvim",
	lazy = false,
  },

  {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {

	},
	config = function()
      local highlight = {
          "CursorColumn",
          "Whitespace",
      }
      require("ibl").setup {
          indent = { highlight = highlight, char = "" },
          whitespace = {
              highlight = highlight,
              remove_blankline_trail = false,
          },
          scope = { enabled = false },
      }
	end
  },

  ---@type LazySpec
  {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
	  -- 👇 in this section, choose your own keymappings!
	  {
		"<leader>-",
		"<cmd>Yazi<cr>",
		desc = "Open yazi at the current file",
	  },
	  {
		-- Open in the current working directory
		"<leader>cd",
		"<cmd>Yazi cwd<cr>",
		desc = "Open the file manager in nvim's working directory" ,
	  },
	  {
		-- NOTE: this requires a version of yazi that includes
		-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
		'<c-up>',
		"<cmd>Yazi toggle<cr>",
		desc = "Resume the last yazi session",
	  },
	},
	---@type YaziConfig
	opts = {
	  -- if you want to open yazi instead of netrw, see below for more info
	  open_for_directories = false,
	  keymaps = {
		show_help = '<f1>',
	  },
	},
  },

  -- treesitter
  {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	config = function () 
	  local configs = require("nvim-treesitter.configs")

	  configs.setup({
		  ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "bash" },
		  sync_install = true,
		  highlight = { enable = true },
		  indent = { enable = true },
		})
	end
  },

  -- autopair
  {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = true
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
    end,
  },

  {
	'chomosuke/typst-preview.nvim',
	ft = 'typst',
	version = '1.*',
	build = function() require 'typst-preview'.update() end,
  },


  {
	'hrsh7th/nvim-cmp',
	dependencies = {
      {
		-- Snippets
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
	  -- Sources
	  {'hrsh7th/cmp-buffer'},
	  {'hrsh7th/cmp-path'},
	  {'saadparwaiz1/cmp_luasnip'},
	  {'hrsh7th/cmp-nvim-lsp'},
	  {'hrsh7th/cmp-omni'},
	  {'quangnguyen30192/cmp-nvim-tags'},
	},
	event = 'InsertEnter',
	config = function()
	  local cmp = require('cmp')
	  require ('luasnip').config.setup {}
	  vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
		  if
			require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		  then
			require("luasnip").unlink_current()
		  end
		end,
	  })

	  cmp.setup({
		completion = {
		  completeopt = 'menu,menuone',
		},
		snippet = {
		  expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		  end,
		},
		sources = cmp.config.sources({
		  { name = 'nvim_lsp' },
		  { name = 'luasnip' },
		}, {
		  { name = 'buffer' },
		  { name = 'path' },
		}),
		mapping = cmp.mapping.preset.insert({
		  ["<C-p>"] = cmp.mapping.select_prev_item(),
		  ["<C-n>"] = cmp.mapping.select_next_item(),
		  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
		  ["<C-f>"] = cmp.mapping.scroll_docs(4),
		  ["<C-Space>"] = cmp.mapping.complete(),
		  ["<C-e>"] = cmp.mapping.close(),

		  ["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		  },

		  ["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
			  cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
			  require("luasnip").expand_or_jump()
			else
			  fallback()
			end
		  end, { "i", "s" }),

		  ["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
			  cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
			  require("luasnip").jump(-1)
			else
			  fallback()
			end
		  end, { "i", "s" }),
		}),

		window = {
		  completion = {
			scrollbar = false,
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
		  },

		  documentation = {
			border = "rounded",
			-- winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
			max_height = 15,
			max_width = 50,
			zindex = 50,
		  },
		},
		experimental = {
		  ghost_text = false,
		},
		formatting = {
		  fields = {'kind', 'abbr', 'menu'},
		  format = function(entry, item)
			local icons = {
			  Namespace = "󰌗",
			  Text = "󰉿",
			  Method = "󰆧",
			  Function = "󰆧",
			  Constructor = "",
			  Field = "󰜢",
			  Variable = "󰀫",
			  Class = "󰠱",
			  Interface = "",
			  Module = "",
			  Property = "󰜢",
			  Unit = "󰑭",
			  Value = "󰎠",
			  Enum = "",
			  Keyword = "󰌋",
			  Snippet = "",
			  Color = "󰏘",
			  File = "󰈚",
			  Reference = "󰈇",
			  Folder = "󰉋",
			  EnumMember = "",
			  Constant = "󰏿",
			  Struct = "󰙅",
			  Event = "",
			  Operator = "󰆕",
			  TypeParameter = "󰊄",
			  Table = "",
			  Object = "󰅩",
			  Tag = "",
			  Array = "[]",
			  Boolean = "",
			  Number = "",
			  Null = "󰟢",
			  Supermaven = "",
			  String = "󰉿",
			  Calendar = "",
			  Watch = "󰥔",
			  Package = "",
			  Copilot = "",
			  Codeium = "",
			  TabNine = "",
			  BladeNav = "",
			}
 			item.kind = string.format('%s %s', icons[item.kind], item.kind)
 			-- Source
 			item.menu = ({
 			  buffer = "[Buffer]",
 			  nvim_lsp = "[LSP]",
 			  luasnip = "[LuaSnip]",
 			  nvim_lua = "[Lua]",
 			  latex_symbols = "[LaTeX]",
 			})[entry.source.name]
 			return item
		  end,
		},
	  })
	end
  },

  {
    "williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
  },

  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "neovim/nvim-lspconfig",
	-- event = "User FilePost",
    config = function()
	  -- lsp keymaps
	  vim.api.nvim_create_autocmd('LspAttach', {
		desc = 'LSP actions',
		callback = function()
		  local bufmap = function(mode, lhs, rhs)
			local opts = {buffer = true}
			vim.keymap.set(mode, lhs, rhs, opts)
		  end

		  -- Displays hover information about the symbol under the cursor
		  bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

		  -- Jump to the definition
		  bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

		  -- Jump to declaration
		  bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

		  -- Lists all the implementations for the symbol under the cursor
		  bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

		  -- Jumps to the definition of the type symbol
		  bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

		  -- Lists all the references 
		  bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

		  -- Displays a function's signature information
		  bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

		  -- Renames all references to the symbol under the cursor
		  bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

		  -- Selects a code action available at the current cursor position
		  bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

		  -- Show diagnostics in a floating window
		  bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

		  -- Move to the previous diagnostic
		  bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

		  -- Move to the next diagnostic
		  bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		end
	  })

	  local lspconfig = require("lspconfig")
	  local capabilities = vim.lsp.protocol.make_client_capabilities()
	  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

 	  local servers = {
 		lua_ls = {
 		  on_init = function(client)
 			local path = client.workspace_folders[1].name
 			if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
 			  return
 			end
 			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
 			  runtime = {
 				version = 'LuaJIT'
 			  },
 			  workspace = {
 				checkThirdParty = true,
 				library = {
 				  vim.env.VIMRUNTIME
 				}
 			  }
 			})
 		  end,
 		  settings = {
 			Lua = {}
 		  }
 		},
 		pyright = {
 		  settings = {
 			python = {
 			  analysis = {
 				autoSearchPaths = true,
 				typeCheckingMode = "basic",
 			  },
 			},
 		  },
 		},
		tinymist = {},
        html = {},
 		clangd = {
 		  cmd = {
 			'clangd',
 			'--background-index',
 			'--header-insertion-decorators=false',
 		  },
 		  -- init_options = { fallbackFlags = { '-std=c++23' } },
 		  root_dir = function(fname)
 			return require('lspconfig').util.root_pattern(unpack({
 			  '.git',
 			  'Makefile',
 			  'CMakeLists.txt',
 			  '.clangd',
 			  '.clang-tidy',
 			  '.clang-format',
 			}))(fname) or require('lspconfig').util.find_git_ancestor(fname)
 		  end,
 		},
 	  }

	  require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
        },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end
  },
})

