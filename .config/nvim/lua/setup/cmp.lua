
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯

local icons = {
  terminal            = "  ",
  paragraph           = "  ",
  buffer              = " 🖹 ",
  bomb                = "  ",
  snippet             = "  ",
  calculator          = "  ",
  folderOpen2         = " ﱮ ",
  tree                = "  ",
}

local source_mapping = {
  npm = icons.terminal .. "NPM",
  nvim_lsp = icons.paragraph .. "LSP",
  buffer = icons.buffer .. "BUF",
  nvim_lua = icons.bomb,
  luasnip = icons.snippet .. "SNP",
  calc = icons.calculator,
  path = icons.folderOpen2,
  treesitter = icons.tree,
}

local buffer_option = {
  -- Complete from all buffers
  get_bufnrs = function()
    return vim.api.nvim_list_bufs()
  end,
}

local border_opts = {
  border = "single",
  winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
}

local function format(entry, vim_item)

  -- Get the item with kind from the lspkind plugin
  local item_with_kind = lspkind.cmp_format({
    mode = "symbol_text",
    maxwidth = 50,
    symbol_map = source_mapping,
  })(entry, vim_item)

  item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
  item_with_kind.menu = source_mapping[entry.source.name]
  item_with_kind.menu = vim.trim(item_with_kind.menu or "")
  item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

  return item_with_kind
end

local function luasnip_cmp(fallback)
  -- replace the expand_or_jumpable() with expand_or_locally_jumpable() 
  -- to only jump inside the snippet region
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

cmp.setup({

  completion = {
    autocomplete = false,
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = "buffer",   priority = 100, option = buffer_option },
    { name = "nvim_lsp", priority = 90 },
    { name = "luasnip",  priority = 80 },
    { name = "npm",      priority = 70 },
  }),

  window = {
    completion = cmp.config.window.bordered(border_opts),
    documentation = cmp.config.window.bordered(border_opts),
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = format,
  },

  mapping = cmp.mapping.preset.insert({

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
      reason = cmp.ContextReason.Auto,
    }), {"i", "c"}),

    ["<A-Left>"] = cmp.mapping(luasnip_cmp, { "i", "s" }),
    ["<A-Right>"] = cmp.mapping(luasnip_cmp, { "i", "s" }),
    ["<C-Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    ["<Cr>"] = cmp.mapping.confirm({ select = false }),

  }),

  experimental = {
    ghost_text = true,
  },

})

