
require("Comment").setup({

  ---Add a space b/w comment and the line
  ---@type boolean
  padding = true,

  ---Whether the cursor should stay at its position
  ---@type boolean
  sticky = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use "^$" to ignore empty lines
  ---@type string|function
  ignore = nil,

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---@type table
  mappings = {
    ---operator-pending mapping
    ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
    basic = true,
    ---extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = false,
    ---extended mapping
    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
    extended = false,
  },

  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = "<leader>c/",
    ---Block-comment toggle keymap
    block = "<leader>b/",
  },

  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = "<leader>c/",
    ---Block-comment keymap
    block = "<leader>b/",
  },

  ---Pre-hook, called before commenting the line
  ---@type function|nil
  ---@param ctx Ctx
  -- pre_hook = function(ctx)
  --   return require("ts_context_commentstring.internal").calculate_commentstring()
  -- end,
  -- pre_hook = function(ctx)
  --   return require("Comment.jsx").calculate(ctx)
  -- end,

  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

  ---Post-hook, called after commenting is done
  ---@type function|nil
  post_hook = nil,

})

