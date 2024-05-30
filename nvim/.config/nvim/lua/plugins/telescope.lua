return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VimEnter",
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

      -- Mappings
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = "Telescope: " .. desc })
      end
      local builtin = require("telescope.builtin")

      -- Two keymaps for find files (for now) because I can't shake my muscle memory
      for _, key in ipairs({ "<leader>ff", "<C-p>" }) do
        map(key, function()
          builtin.find_files({ hidden = true })
        end, "[F]ind [F]iles")
      end
      map("<leader>ft", builtin.git_files, "[F]ind files [t]racked in git")
      map("<leader>fg", builtin.live_grep, "[F]ind with [g]rep")
      map("<leader>fw", builtin.grep_string, "[F]ind current [W]ord")
      map("<leader>fd", builtin.diagnostics, "[F]ind in [Diagnostics]")
      map("<leader>fr", builtin.resume, "[F]ind [R]esume")
      map("<leader>fh", builtin.help_tags, "[F]ind [H]elp")
      map("<leader>/", builtin.current_buffer_fuzzy_find, "Find in current buffer")
      map("<leader>fb", function()
        builtin.buffers({ sort_mru = true, sort_lastused = true })
      end, "[F]ind in open [b]uffers")
      map("<leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
    end,
  },
}
