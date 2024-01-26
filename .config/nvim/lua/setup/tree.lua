
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local api = require("nvim-tree.api")
local lib = require("nvim-tree.lib")

local function grep_at(node)
  if not node then
    node = lib.get_node_at_cursor()
  end
  local path = node.absolute_path or uv.cwd()
  if node.type ~= "directory" and node.parent then
    path = node.parent.absolute_path
  end
  require("telescope.builtin").live_grep({
    search_dirs = { path },
    prompt_title = string.format("Grep in [%s]", vim.fs.basename(path)),
  })
end

local function on_attach(bufnr)

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- mark operation
  local mark_move_j = function()
    api.marks.toggle()
    vim.cmd("norm j")
  end
  local mark_move_k = function()
    api.marks.toggle()
    vim.cmd("norm k")
  end

  -- marked files operation
  local mark_trash = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    vim.ui.input(
      { prompt = string.format("Trash %s files? [y/n] ", #marks) },
      function(input)
        if input == "y" then
          for _, node in ipairs(marks) do
            api.fs.trash(node)
          end
          api.marks.clear()
          api.tree.reload()
        end
      end
    )
  end
  local mark_remove = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    vim.ui.input(
      { prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) },
      function(input)
        if input == "y" then
          for _, node in ipairs(marks) do
            api.fs.remove(node)
          end
          api.marks.clear()
          api.tree.reload()
        end
      end
    )
  end

  local mark_copy = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    for _, node in pairs(marks) do
      api.fs.copy.node(node)
    end
    api.marks.clear()
    api.tree.reload()
  end
  local mark_cut = function()
    local marks = api.marks.list()
    if #marks == 0 then
      table.insert(marks, api.tree.get_node_under_cursor())
    end
    for _, node in pairs(marks) do
      api.fs.cut(node)
    end
    api.marks.clear()
    api.tree.reload()
  end

  vim.keymap.set("n", "<S-Down>", mark_move_j, opts("Toggle Bookmark Down"))
  vim.keymap.set("n", "<S-Up>", mark_move_k, opts("Toggle Bookmark Up"))

  vim.keymap.set("n", "yy", mark_copy, opts("Copy Marked File(s)"))
  vim.keymap.set("n", "dd", mark_cut, opts("Cut Marked File(s)"))
  vim.keymap.set("n", "D", mark_trash, opts("Trash Marked File(s)"))
  vim.keymap.set("n", "<A-D>", mark_remove, opts("Remove Marked File(s)"))

  -- vim.keymap.set("n", "bm", api.marks.bulk.move, opts("Move Bookmarked"))

  local mappings = {
    -- BEGIN_DEFAULT_ON_ATTACH

    ["<A-Enter>"] = { api.tree.change_root_to_node, "CD" },

    -- ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
    ["i"] = { api.node.show_info_popup, "Info" },
    ["t"] = { api.node.open.tab, "Open: New Tab" },
    ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
    ["s"] = { api.node.open.horizontal, "Open: Horizontal Split" },
    ["<leader>fg"] = { grep_at, "Grep At" },
    ["<CR>"] = { api.node.open.edit, "Open" },
    ["<Tab>"] = { api.node.open.preview, "Open Preview" },

    [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
    ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
    ["<A-Home>"] = { api.node.navigate.parent, "Parent Directory" },
    ["<A-PageUp>"] = { api.node.navigate.sibling.first, "First Sibling" },
    ["<A-PageDown>"] = { api.node.navigate.sibling.last, "Last Sibling" },
    ["<A-BS>"] = { api.tree.change_root_to_parent, "Up" },
    ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },

    ["X"] = { api.node.run.cmd, "Run Command" },
    ["a"] = { api.fs.create, "Create" },
    -- ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
    -- ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },

    -- copy/paste
    -- ["yy"] = { api.fs.copy.node, "Copy" },
    ["yn"] = { api.fs.copy.filename, "Copy Name" },
    ["yp"] = { api.fs.copy.relative_path, "Copy Relative Path" },
    ["yP"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
    -- ["dd"] = { api.fs.cut, "Cut" },
    ["p"] = { api.fs.paste, "Paste" },

    -- ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
    ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
    ["]c"] = { api.node.navigate.git.next, "Next Git" },
    -- ["T"] = { api.fs.trash, "Trash" },
    -- ["D"] = { api.fs.remove, "Delete" },
    ["<A-=>"] = { api.tree.expand_all, "Expand All" },
    ["<A-->"] = { api.tree.collapse_all, "Collapse" },
    -- ["e"] = { api.fs.rename_basename, "Rename: Basename" },
    -- ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
    -- ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
    ["F"] = { api.live_filter.clear, "Clean Filter" },
    ["f"] = { api.live_filter.start, "Filter" },
    ["?"] = { api.tree.toggle_help, "Help" },
    ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
    ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
    ["M"] = { api.marks.toggle, "Toggle Bookmark" },
    ["o"] = { api.node.open.edit, "Open" },
    ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
    -- ["Q"] = { api.tree.close, "Close" },
    ["r"] = { api.fs.rename, "Rename" },
    ["R"] = { api.fs.rename_sub, "Rename: Omit Filename" },
    ["<C-r>"] = { api.tree.reload, "Refresh" },
    ["<C-o>"] = { api.node.run.system, "Run System" },
    -- ["S"] = { api.tree.search_node, "Search" },
    -- ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
    ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
    ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
    -- END_DEFAULT_ON_ATTACH

    -- Mappings migrated from view.mappings.list
    -- ["l"] = { api.node.open.edit, "Open" },
    -- ["<CR>"] = { api.node.open.edit, "Open" },
    -- ["o"] = { api.node.open.edit, "Open" },
    -- ["h"] = { api.node.navigate.parent_close, "Close Directory" },
    -- ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
    -- ["C"] = { api.tree.change_root_to_node, "CD" },
  }

  for keys, mapping in pairs(mappings) do
    vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
  end

end

require("nvim-tree").setup({

  on_attach = on_attach,

  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  sync_root_with_cwd = true,

  --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
  respect_buf_cwd = true,

  ui = {
    confirm = {
      remove = false,
      trash = false,
    },
  },

  sort = {
    sorter = "name",
    folders_first = true,
  },

  view = {
    number = true,
    cursorline = true,
    width = 40,
  },

  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },

   diagnostics = {
     enable = true,
     show_on_dirs = true,
     icons = {
       hint = "",
       info = "",
       warning = "",
       error = "",
     },
   },

  renderer = {
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    highlight_modified = "icon",
    root_folder_label = function(path)
      return "../"
    end,
    icons = {
      git_placement = "after",
      modified_placement = "after",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "➜",
          untracked = "",
          deleted = "",
          ignored = "◌",
        },
      },
    },

  },

  actions = {

    expand_all = {
      exclude = { ".git", "node_modules", "var" },
    },

    open_file = {
      resize_window = false,
    },

  },

  filters = {
    -- Ignore files based on `.gitignore`
    git_ignored = false,
  },

  live_filter = {
    always_show_folders = false,
  },

  update_focused_file = {
    -- Update the focused file on `BufEnter`,
    -- un-collapses the folders recursively until it finds the file.
    enable = true,
    -- Update the root directory of the tree if the file is not under current root directory.
    -- It prefers vim's cwd and `root_dirs`.
    -- Otherwise it falls back to the folder containing the file.
    update_root = true,
    -- List of buffer names and filetypes that will not update the root dir of the tree
    -- if the file isn't found under the current root directory.
    ignore_list = {},
  },

})

