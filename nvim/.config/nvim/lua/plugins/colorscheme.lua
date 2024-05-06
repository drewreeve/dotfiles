return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Disable string italics
      italic = {
        strings = false,
      },
      -- Fix signcolumn
      overrides = {
        SignColumn = { link = "Normal" },
        GruvboxGreenSign = { bg = "" },
        GruvboxOrangeSign = { bg = "" },
        GruvboxPurpleSign = { bg = "" },
        GruvboxYellowSign = { bg = "" },
        GruvboxRedSign = { bg = "" },
        GruvboxBlueSign = { bg = "" },
        GruvboxAquaSign = { bg = "" },
      },
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      vim.cmd([[colorscheme gruvbox ]])
    end,
  },
}
