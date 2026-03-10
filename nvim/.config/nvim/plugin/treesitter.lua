vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

-- stylua: ignore
local ensure_installed = {
  "bash",   "css",      "diff",      "dockerfile",       "gitcommit",
  "go",     "graphql",  "html",      "javascript",       "json",
  "json5",  "lua",      "markdown",  "markdown_inline",  "python",
  "query",  "regex",    "toml",      "typescript",       "vim",
  "yaml",
}

-- Install parsers
local ts = require("nvim-treesitter")
ts.install(ensure_installed):wait(300000)

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function(args)
    local buf = args.buf

    -- highlighting
    if not pcall(vim.treesitter.start) then
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if lang and require("nvim-treesitter.parsers")[lang] then
        vim.schedule(function()
          ts.install({ lang }):wait(300000)
          pcall(vim.treesitter.start, buf)
        end)
      end
    end

    -- indentation
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Run :TSUpdate if treesitter is updated
vim.api.nvim_create_autocmd({ "PackChanged" }, {
  group = vim.api.nvim_create_augroup("TreesitterUpdated", { clear = true }),
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.notify("nvim-treesitter was updated, running :TSUpdate", vim.log.levels.INFO)
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})
