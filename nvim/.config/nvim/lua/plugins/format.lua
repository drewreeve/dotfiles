return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
