
local notify = require("notify")

notify.setup({
  -- level = vim.log.levels.WARN,
  timeout = 3000,
  render = "minimal",
  stages = "slide",
  top_down = false,
})

vim.notify = function(msg, ...)
  return notify(msg, ...)
end

