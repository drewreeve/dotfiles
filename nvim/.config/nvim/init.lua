-- Set leader early
vim.g.mapleader = ' '

require('plugins')
require('drew/lsp')

for _, mod in ipairs(vim.api.nvim_get_runtime_file('lua/plugin/**/*.lua', true)) do
  local ok, msg = pcall(loadfile(mod))

  if not ok then
    print("Failed to load: ", mod)
    print("\t", msg)
  end
end

local opt = vim.opt

-- ===========================================================================
-- General settings
-- ===========================================================================

opt.hidden = true          -- Allow unsaved background buffers
opt.cursorline = true      -- Highlight current line
opt.number = true          -- Show line numbers
opt.relativenumber = true  -- Show relative line numbers
opt.joinspaces = false     -- Use one space afer punctuation
opt.scrolloff = 3          -- More context when scrolling off end of buffer

-- Open new split panes to right and bottom
opt.splitbelow = true
opt.splitright = true

-- Enhanced tab completion
opt.wildmode = { 'list:longest', 'list:full' }

-- Make searches case-sensitive only if they contain upper-case characters
opt.ignorecase = true
opt.smartcase = true

-- Softtabs, 2 spaces
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true
opt.expandtab = true

opt.updatetime = 1000

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess:append("c")

-- Highlight where 80 characters is
opt.colorcolumn = '81'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = 'number'


-- Show effects of commands incrementally
opt.inccommand = 'nosplit'

-- Disable swapfiles
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Colours
opt.termguicolors = true
vim.g.gruvbox_italic = 1
vim.g.gruvbox_sign_column = 'bg0'
vim.cmd [[colorscheme gruvbox ]]

-- Use system clipboard
opt.clipboard = 'unnamedplus'


-- ===========================================================================
-- Mappings
-- ===========================================================================

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Clear highlighted searches
map('n', '<leader>c', ':nohlsearch<CR>', {silent = true})

-- Switch between last 2 files
map('n', '<leader><leader>', '<C-^>')

-- Move around splits with <c-hjkl>
map('n', '<C-h>', '<C-w>h', {silent = true})
map('n', '<C-j>', '<C-w>j', {silent = true})
map('n', '<C-k>', '<C-w>k', {silent = true})
map('n', '<C-l>', '<C-w>l', {silent = true})

-- ===========================================================================
-- Telescope
-- ===========================================================================

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

require('telescope').load_extension('fzf')

map('n', '<C-p>',
  "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>",
  {silent = true})

-- ===========================================================================
-- Treesitter
-- ===========================================================================

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}

-- ===========================================================================
-- vim-test
-- ===========================================================================

map('n', '<leader>t', ':TestFile<CR>', {silent=true})
map('n', '<leader>s', ':TestNearest<CR>', {silent=true})
map('n', '<leader>l', ':TestLast<CR>', {silent=true})
map('n', '<leader>a', ':TestSuite<CR>', {silent=true})
map('n', '<leader>gt', ':TestVisit<CR>', {silent=true})

-- ===========================================================================
-- lualine
-- ===========================================================================

require('lualine').setup{
  options = {
    theme = 'gruvbox'
  },
  sections = {
    lualine_x = {
      {'diagnostics',  sources = {'nvim_diagnostic', 'coc'},
        icons_enabled = false, color_error = '#cc241d',
        color_warn = '#d65d0e', color_info = '#458588'},
      'encoding',
      {'fileformat', icons_enabled = false},
      'filetype'
    }
  }
}
