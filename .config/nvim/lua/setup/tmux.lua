
local tmux = require("tmux")

tmux.setup({
  navigation = {
    enable_default_keybindings = false,
  },
})

vim.keymap.set({ "n", "i" }, "<A-Left>", function ()
  tmux.move_left()
end)

vim.keymap.set({ "n", "i" }, "<A-Right>", function ()
  tmux.move_right()
end)

vim.keymap.set({ "n", "i" }, "<A-Down>", function ()
  tmux.move_bottom()
end)

vim.keymap.set({ "n", "i" }, "<A-Up>", function ()
  tmux.move_top()
end)

