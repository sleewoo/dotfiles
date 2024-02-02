require("lualine").setup({

  options = {
    theme = "catppuccin",
    globalstatus = true,
    ignore_focus = { "NvimTree", "toggleterm" },
  },

  sections = {
    lualine_c = {
      {
        "filename",
        file_status = true,
        newfile_status = false,
        path = 1,
        symbols = {
          modified = "●",
          readonly = "◌",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      }
    },
  },

  tabline = {
    lualine_a = {
      {
        "tabs",
        mode = 1,
        fmt = function(_, context)
          return " 󰈙 " .. context.tabnr
        end
      }
    },
  },

  extensions = {
    "nvim-tree",
    "symbols-outline",
    "quickfix",
    "toggleterm",
    "lazy",
  },

})
