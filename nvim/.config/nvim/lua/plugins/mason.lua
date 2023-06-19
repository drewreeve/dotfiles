return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        callback = function()
          local registry = require("mason-registry")

          for _, pkg_name in ipairs { "stylua", "shfmt", "shellcheck" } do
            local ok, pkg = pcall(registry.get_package, pkg_name)
            if ok then
              if not pkg:is_installed() then
                pkg:install()
              end
            end
          end
        end
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'neovim/nvim-lspconfig' },
  }
}
