vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    sh = { "shfmt" },
    json = { "prettier" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
})
