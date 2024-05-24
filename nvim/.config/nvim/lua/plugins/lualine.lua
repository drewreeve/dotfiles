return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic", "coc" },
              icons_enabled = false,
              color_error = "#cc241d",
              color_warn = "#d65d0e",
              color_info = "#458588",
            },
            -- "encoding",
            -- { "fileformat", icons_enabled = false },
            "filetype",
          },
        },
      })

      require("lualine").get_config()
    end,
  },
}
