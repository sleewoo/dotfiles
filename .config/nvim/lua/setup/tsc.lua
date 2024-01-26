
local tsc = require("tsc")
local trouble = require("trouble")

tsc.setup()

-- Replace the quickfix window with Trouble when viewing TSC results
local function replace_quickfix_with_trouble()

  local title = vim.fn.getqflist({ title = 0 }).title

  if title ~= "TSC" then
    return
  end

  vim.defer_fn(function()
    vim.cmd("cclose")
    trouble.toggle("quickfix")
  end, 0)

end

local group = vim.api.nvim_create_augroup("ReplaceQuickfixWithTrouble", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "quickfix",
  group = group,
  callback = replace_quickfix_with_trouble,
})

local projectResolver = function(opts)

  local project = "tsconfig.json"

  if opts.fargs[1] then
    return opts.fargs[1] .. "/" .. project
  end

  return project

end

vim.api.nvim_create_user_command(
  "TC",
  function (opts)

    tsc.setup({
      flags = {
        project = projectResolver(opts),
        watch = false,
      },
    })

    tsc.run()

  end,
  {
    nargs = "?",
  }
)

vim.api.nvim_create_user_command(
  "TW",
  function (opts)

    tsc.setup({
      flags = {
        project = projectResolver(opts),
        watch = true,
      },
    })

    tsc.run()

  end,
  {
    nargs = "?",
  }
)

