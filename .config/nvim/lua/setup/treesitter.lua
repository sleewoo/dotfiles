require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "tsx",
    "typescript",
    "javascript",
    "html",
    "css",
    "vue",
    "gitcommit",
    "json",
    "json5",
    "lua",
    "markdown",
    "vim",
  },                              -- one of "all", or a list of languages

  sync_install = false,           -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "haskell" }, -- list of parsers to ignore installing

  highlight = {
    enable = true,
    -- disable = { "" },  -- list of language that will be disabled
    -- additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = "<cr>",
      node_incremental  = "<cr>",
      scope_incremental = "<tab>",
      node_decremental  = "<s-tab>",
    },
  },

  indent = {
    enable = false,
  },

  rainbow = {
    enable = false,
    extended_mode = true,
  },

})

require("ts_context_commentstring").setup({
  enable = true,
  enable_autocmd = false,
})
