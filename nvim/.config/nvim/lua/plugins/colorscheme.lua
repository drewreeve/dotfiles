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
    -- config = function(_, opts)
    --   -- require("gruvbox").setup(opts)
    -- end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "EdenEast/nightfox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
