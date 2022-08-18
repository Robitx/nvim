local status_ok, mason, mason_lspconfig, lspconfig

status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end


status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end


mason.setup {
    ui = {
        icons = {
            package_installed = "✓"
        }
    }
}

mason_lspconfig.setup {
    ensure_installed = { "sumneko_lua" },
    automatic_installation = false
}

mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    ["sumneko_lua"] = function ()
        lspconfig.sumneko_lua.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
})

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  'gopls',
}

--
local custom_configs = {
  sumneko_lua = require("user.lsp.settings.sumneko_lua"),
  gopls = require("user.lsp.settings.gopls"),
  pyright = require("user.lsp.settings.pyright"),
}

local opts = {}
for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if custom_configs[server] then
    opts = vim.tbl_deep_extend("force", custom_configs[server], opts)
  end

  lspconfig[server].setup(opts)
end
