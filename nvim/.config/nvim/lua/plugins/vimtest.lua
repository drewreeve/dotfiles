return {
  {
    "janko-m/vim-test",
    dependencies = { "tpope/vim-dispatch" },
    keys = {
      {
        "<leader>t",
        ":TestFile<CR>",
      },
      {
        "<leader>s",
        ":TestNearest<CR>",
      },
      {
        "<leader>l",
        ":TestLast<CR>",
      },
      {
        "<leader>a",
        ":TestSuite<CR>",
      },
      {
        "<leader>gt",
        ":TestVisit<CR>",
      },
    },
  },
}
