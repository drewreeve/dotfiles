return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local tele_actions = require('telescope.actions')
      require('telescope').setup{
        defaults = {
          set_env = {['COLORTERM'] = 'truecolor'},
          mappings = {
            i = {
              ["<C-j>"] = tele_actions.move_selection_next,
              ["<C-k>"] = tele_actions.move_selection_previous,
              ["<esc>"] = tele_actions.close
            },
            n = {
              ["<C-j>"] = tele_actions.move_selection_next,
              ["<C-k>"] = tele_actions.move_selection_previous,
            }
          }
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          }
        }
      }
    end,
    keys = {
      {
        '<C-p>', "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>",
        desc = "Find files"
      },
    }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    config = function()
      require('telescope').load_extension('fzf')
    end,
  }
}
