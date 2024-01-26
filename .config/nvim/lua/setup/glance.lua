
require("glance").setup({

  winbar = {
    enable = true, -- Available strating from nvim-0.8+
  },

})

vim.keymap.set("n", "gd", "<cmd>Glance definitions<cr>")
vim.keymap.set("n", "gr", "<cmd>Glance references<cr>")
vim.keymap.set("n", "gy", "<cmd>Glance type_definitions<cr>")
vim.keymap.set("n", "gm", "<cmd>Glance implementations<cr>")

