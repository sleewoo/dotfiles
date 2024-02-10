local lspconfig = require("lspconfig")

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion = cmp_capabilities.textDocument.completion

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

require("mason-lspconfig").setup({

  ensure_installed = {
    "bashls", "cssls", "dockerls", "html", "jsonls", "tsserver", "yamlls",
    "marksman", "sqlls", "taplo", "volar", "emmet_ls", "lua_ls", "typos_lsp",
    "biome",
  },

})

require("mason-lspconfig").setup_handlers({

  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn"t have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    if require("neoconf").get(server_name .. ".disable") then
      return
    end

    local server_config = {
      capabilities = capabilities,
      flags = flags,
    }

    if server_name == "tsserver" then
      server_config.filetypes = { "typescript", "javascript" }
    end

    if server_name == "volar" then
      server_config.filetypes = { "vue" }
    end

    if server_name == "emmet_ls" then
      server_config.filetypes = { "html", "vue", "css" }
    end

    lspconfig[server_name].setup(server_config)
  end,

  -- dedicated handlers for specific servers

})
