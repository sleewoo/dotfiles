local prettier_cmd = { { "prettierd", "prettier" } }

require("conform").setup({

  formatters_by_ft = {
    typescript = prettier_cmd,
    javascript = prettier_cmd,
    vue = prettier_cmd,
    json = prettier_cmd,
    jsonc = prettier_cmd,
    yaml = prettier_cmd,
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
