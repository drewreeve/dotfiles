return {
  "brenoprata10/nvim-highlight-colors",
  event = "InsertEnter",
  opts = {
    render = "background",
  },
  config = function(_, opts)
    require("nvim-highlight-colors").setup(opts)
  end,
}
