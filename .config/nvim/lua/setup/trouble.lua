
local trouble = require("trouble")

trouble.setup({

  auto_open = false,
  auto_preview = false,
  group = true,

  action_keys = {
    open_split = { "s" }, -- open buffer in new split
    open_vsplit = { "v" }, -- open buffer in new vsplit
    open_tab = { "t" }, -- open buffer in new tab
    hover = "i", -- opens a small popup with the full multiline message
  },

})

vim.keymap.set("n", "<leader>d", function() trouble.toggle("workspace_diagnostics") end)

