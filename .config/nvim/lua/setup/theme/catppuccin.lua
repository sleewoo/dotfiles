require("catppuccin").setup({
  flavour = "macchiato", -- latte, frappe, macchiato, mocha
  show_end_of_buffer = true,
  dim_inactive = {
    enabled = false,  -- dims the background color of inactive window
    shade = "light",
    percentage = 0.5, -- percentage of the shade to apply to the inactive window
  },
})

vim.cmd.colorscheme "catppuccin"
