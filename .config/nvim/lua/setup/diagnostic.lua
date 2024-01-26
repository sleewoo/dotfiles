
-- Only show errors matching the given severity
local severity = {
  -- Specify a range of severities
  min = vim.diagnostic.severity.WARN,
}

local signs = {
  { name = "DiagnosticSignError", text = "", texthl = "DiagnosticSignError" },
  { name = "DiagnosticSignWarn", text = "", texthl = "DiagnosticSignWarn" },
  { name = "DiagnosticSignHint", text = "󰌵", texthl = "DiagnosticSignHint" },
  { name = "DiagnosticSignInfo", text = "󰋼", texthl = "DiagnosticSignInfo" },
  { name = "DapStopped", text = "󰁕", texthl = "DiagnosticWarn" },
  { name = "DapBreakpoint", text = "", texthl = "DiagnosticInfo" },
  { name = "DapBreakpointRejected", text = "", texthl = "DiagnosticError" },
  { name = "DapBreakpointCondition", text = "", texthl = "DiagnosticInfo" },
  { name = "DapLogPoint", text = ".>", texthl = "DiagnosticInfo" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, sign)
end

vim.diagnostic.config({
  virtual_text = true,
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  signs = {
    active = signs,
    severity = severity,
  },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

-- show errors on CursorHold
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

