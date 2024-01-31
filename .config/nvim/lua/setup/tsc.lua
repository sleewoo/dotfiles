local tsc = require("tsc")
local trouble = require("trouble")

local merge = function(a, b)
  local c = {}
  for k, v in pairs(a) do c[k] = v end
  for k, v in pairs(b) do c[k] = v end
  return c
end

local userCmdFactory = function(cmd, flags)
  vim.api.nvim_create_user_command(
    cmd,
    function(opts)
      local project = "tsconfig.json"

      if opts.fargs[1] then
        return opts.fargs[1] .. "/" .. project
      end

      tsc.setup({
        -- options goes here
        flags = merge({ project = project }, flags)
      })

      tsc.run()

      -- deleting default cmd to eliminate confusion
      vim.api.nvim_del_user_command("TSC")
    end,
    {
      nargs = "?",
    }
  )
end

userCmdFactory("TC", { watch = false })
userCmdFactory("TW", { watch = true })

-- Replace the quickfix window with Trouble when viewing TSC results
local function replace_quickfix_with_trouble()
  local qflist = vim.fn.getqflist({ title = 0, items = 0 })

  if qflist.title ~= "TSC" then
    return
  end

  -- close trouble if there are no more items in the quickfix list
  if next(qflist.items) == nil then
    vim.defer_fn(trouble.close, 0)
    return
  end

  vim.defer_fn(function()
    vim.cmd("cclose")
    trouble.open("quickfix")
  end, 0)
end

local group = vim.api.nvim_create_augroup("ReplaceQuickfixWithTrouble", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "quickfix",
  group = group,
  callback = replace_quickfix_with_trouble,
})
