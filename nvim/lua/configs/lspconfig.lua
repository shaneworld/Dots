local configs = require "nvchad.configs.lspconfig"
local servers = {
  html = {},
  bashls = {},
  lemminx = {},
  rust_analyzer = {},
  tinymist = {},
  clangd = {},
  jdtls = {},
  texlab = {},
  kotlin_language_server = {},
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
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
