return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- options = {
      --   theme = "catppuccin",
      -- },
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
    },
  },
}
