return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      json = { "prettier" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
