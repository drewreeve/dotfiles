local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

---
--- Tree-sitter
---

now_if_args(function()
  -- stylua: ignore
  local ts_update = function() vim.cmd("TSUpdate") end
  Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

  add({
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

  local ts = require("nvim-treesitter")
  require("nvim-treesitter").install(ensure_installed):wait(300000)

  Config.new_autocmd("FileType", "*", function(ev)
    if not pcall(vim.treesitter.start) then
      local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
      if lang and require("nvim-treesitter.parsers")[lang] then
        vim.schedule(function()
          ts.install({ lang }):wait(300000)
          pcall(vim.treesitter.start, ev.buf)
        end)
      end
    end
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end, "Enable treesitter highlighting/identation")
end)

---
--- LSP
---

now_if_args(function()
  add({
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/b0o/schemastore.nvim",
  })

  require("mason").setup()
  require("mason-lspconfig").setup()

  require("mason-tool-installer").setup({
    ensure_installed = {
      "ansiblels",
      "bashls",
      "jsonls",
      "lua_ls",
      "pyright",
      "ruff",
      "shellcheck",
      "shfmt",
      "stylua",
      -- "ty",
      "yamlls",
    },
  })
end)

---
--- Completion
---

now_if_args(function()
  add({
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
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
end)

---
--- Formatting
---

later(function()
  add({
    "https://github.com/stevearc/conform.nvim",
  })

  require("conform").setup({
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
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
end)

---
--- Testing
---

later(function()
  add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/antoinemadec/FixCursorHold.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/nvim-neotest/neotest-python",
  })

  require("neotest").setup({
    adapters = {
      require("neotest-python"),
    },
  })
end)

---
--- Utils
---

later(function()
  add({
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/tpope/vim-eunuch",
  })

  require("oil").setup({
    keymaps = {
      ["<C-h>"] = false,
      ["<C-s>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
  })
end)

---
--- Colorscheme / Statusline
---

Config.now(function()
  add({
    "https://github.com/sainnhe/gruvbox-material",
    "https://github.com/nvim-lualine/lualine.nvim",
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/lewis6991/gitsigns.nvim",
  })

  require("nvim-highlight-colors").setup({})
  require("gitsigns").setup()

  require("lualine").setup({
    sections = {
      lualine_b = { "branch", "diagnostics" },
      lualine_c = {
        { "filename", path = 1 },
      },
      lualine_x = {
        -- "encoding",
        -- { "fileformat", icons_enabled = false },
        "filetype",
      },
    },
  })

  require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
      blink_cmp = true,
      snacks = true,
    },
  })
  vim.cmd.colorscheme("catppuccin")
end)
