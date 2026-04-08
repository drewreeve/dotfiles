vim.filetype.add({
  pattern = {
    [".*%.yml%.j2"] = "yaml.jinja",
    [".*%.yaml%.j2"] = "yaml.jinja",
  },
})
vim.treesitter.language.register("yaml", "yaml.jinja")
