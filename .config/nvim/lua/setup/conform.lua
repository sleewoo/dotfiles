
local biome_cmd = { { "biome" } }
local beautysh_args = { "--indent-size", "2", "--force-function-style", "fnpar" }

require("conform").setup({

  formatters = {
    beautysh = {
      prepend_args = beautysh_args
    }
  },

  formatters_by_ft = {
    typescript = biome_cmd,
    javascript = biome_cmd,
    json = biome_cmd,
    jsonc = biome_cmd,
    sh = { { "beautysh" } },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

