return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",

      -- cmp source plugins
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      return {
        completion = { completeopt = "menu,menuone,noselect" },

        mapping = cmp.mapping.preset.insert({
          -- Select [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          -- Select [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),

          -- Scroll documentation [b]ack and [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        }),

        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },

        window = {
          side_padding = 1,
          -- completion = {
          --   border = "rounded",
          -- },
        },
        --- Fix warning about missing required fields
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "codicons",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      }
    end,
  },
  { -- Adds a number of user-friendly snippets
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    opts = {
      delete_check_events = "TextChanged",
    },
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip.loaders.from_vscode").lazy_load(opts)
        end,
      },
      { -- Append luasnip specific config to nvim-cmp
        "hrsh7th/nvim-cmp",
        dependencies = { "saadparwaiz1/cmp_luasnip" },
        keys = {
          {
            "<C-j>",
            function()
              local luasnip = require("luasnip")
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end,
            mode = { "i", "s" },
          },
          {
            "<C-k>",
            function()
              local luasnip = require("luasnip")
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end,
            mode = { "i", "s" },
          },
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
          table.insert(opts.sources, { name = "luasnip" })
        end,
      },
    },
  },

  { -- Configures luals for editing neovim config
    "folke/lazydev.nvim",
    cmd = "LazyDev",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  { -- Add completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "lazydev", group_index = 0 })
    end,
  },
}
