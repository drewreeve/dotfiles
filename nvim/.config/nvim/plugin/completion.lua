vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("mini.snippets").setup({
  snippets = {
    require("mini.snippets").gen_loader.from_lang(),
  },
})

require("blink.cmp").setup({
  cmdline = { enabled = false },
  snippets = { preset = "mini_snippets" },

  completion = {
    list = { selection = { preselect = false, auto_insert = true } },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    ghost_text = { enabled = true },
  },

  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-j>"] = { "snippet_forward", "fallback" },
    ["<C-k>"] = { "snippet_backward", "fallback" },
  },

  signature = { enabled = true },

  sources = {
    default = { "lsp", "path", "buffer", "snippets" },
  },
})
