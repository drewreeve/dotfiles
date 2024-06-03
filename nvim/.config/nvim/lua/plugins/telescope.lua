return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    cmd = "Telescope",
    ft = "mason", -- Allows mason to load telescope for filtering
    keys = {
      { "<C-p>", "<cmd>Telescope find_files hidden=true<cr>", desc = "[F]ind [F]iles" },
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "[F]ind [F]iles" },
      { "<leader>ft", "<cmd>Telescope git_files<cr>", desc = "[F]ind files [t]racked in git" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[F]ind with [g]rep" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "[F]ind current [W]ord" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind in [Diagnostics]" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "[F]ind [R]esume" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[F]ind [H]elp" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true,sort_lastused=true<cr>",
        desc = "[F]ind in open [b]uffers",
      },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[F]ind [K]eymaps" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "flex",
          layout_config = {
            flex = {
              flip_columns = 120,
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<esc>"] = require("telescope.actions").close,
            },
            n = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
          prompt_prefix = "    ",
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
        pickers = {
          live_grep = {
            additional_args = function(_)
              return { "--hidden" }
            end,
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}
