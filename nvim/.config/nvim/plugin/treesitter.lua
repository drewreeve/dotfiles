vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

local ensure_installed = {
  "bash",
  "css",
  "diff",
  "dockerfile",
  "gitcommit",
  "go",
  "graphql",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

require("nvim-treesitter").install(ensure_installed)

-- register and start parsers for filetypes
for _, parser in ipairs(ensure_installed) do
  local filetypes = parser -- In this case, parser is the filetype/language name
  vim.treesitter.language.register(parser, filetypes)

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = filetypes,
    callback = function(event)
      vim.treesitter.start(event.buf, parser)
    end,
  })
end
