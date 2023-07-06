return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        ansiblels = {},
        bashls = {},
        lua_ls = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      },
    },
    config = function(_, opts)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(opts.servers),
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            settings = opts.servers[server_name],
          })
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          local registry = require("mason-registry")

          for _, pkg_name in ipairs({ "stylua", "shfmt", "shellcheck" }) do
            local ok, pkg = pcall(registry.get_package, pkg_name)
            if ok then
              if not pkg:is_installed() then
                pkg:install()
              end
            end
          end
        end,
      })
    end,
  },
}
