local tsc = require("tsc")

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
