return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    config = function()
      local tele_actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          set_env = { ["COLORTERM"] = "truecolor" },
          mappings = {
            i = {
              ["<C-j>"] = tele_actions.move_selection_next,
              ["<C-k>"] = tele_actions.move_selection_previous,
              ["<esc>"] = tele_actions.close,
            },
            n = {
              ["<C-j>"] = tele_actions.move_selection_next,
              ["<C-k>"] = tele_actions.move_selection_previous,
            },
          },
        },
      })
    end,
    keys = {
      {
        "<C-p>",
        "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>",
        desc = "Find files",
      },
    },
  },
}
