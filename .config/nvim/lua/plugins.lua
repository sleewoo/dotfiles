return {

  {
    -- set up neoconf.nvim BEFORE nvim-lspconfig
    "folke/neoconf.nvim",
    lazy = false,
    config = function()
      require("neoconf").setup()
    end
  },

  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("setup.theme.nord")
  --   end
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("setup.theme.catppuccin")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("setup.lualine")
    end
  },

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    config = function()
      require("setup.treesitter")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  -- Navigating (Telescope/Tree/Refactor)
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "folke/trouble.nvim" },
    },
    config = function()
      require("setup.telescope")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeToggle",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
    },
    keys = {
      { "<leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", desc = "Tree" },
    },
    config = function()
      require("setup.tree")
    end
  },
  {
    "gbprod/stay-in-place.nvim",
    lazy = false,
    config = true, -- run require("stay-in-place").setup()
  },

  -- LSP Base
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "folke/neoconf.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("setup.lspconfig")
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
    end
  },

  -- LSP Cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("setup.cmp")
    end,
  },

  -- LSP Addons
  { "onsails/lspkind-nvim" },
  {
    "dmmulroy/tsc.nvim",
    lazy = false,
    dependencies = {
      "folke/trouble.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("setup.tsc")
    end
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("setup.trouble")
    end
  },
  {
    "dnlhc/glance.nvim",
    lazy = false,
    config = function()
      require("setup.glance")
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    event = "LspAttach",
    config = function()
      require("setup.symbols-outline")
    end
  },

  -- Generic
  {
    "rcarriga/nvim-notify",
    lazy = false,
    init = function()
      require("setup.notify")
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("setup.toggleterm")
    end
  },
  {
    "farmergreg/vim-lastplace",
    lazy = false,
  },
  {
    "tpope/vim-rsi",
    lazy = false,
  },
  {
    "tpope/vim-surround",
    lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("setup.snippets")
    end
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    branch = "jsx",
    config = function()
      require("setup.comment")
    end,
  },
  {
    "LudoPinelli/comment-box.nvim"
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "vuki656/package-info.nvim",
    event = "BufEnter package.json",
    config = function()
      require("setup.package-info")
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("setup.autopairs")
    end,
  },
  {
    "aserowy/tmux.nvim",
    lazy = false,
    config = function()
      require("setup.tmux")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("setup.git.signs")
    end,
  },

  -- Formatters
  {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
      require("setup.conform")
    end,
  }

}
