require('plugins')

-- ===========================================================================
-- General settings
-- ===========================================================================

vim.o.hidden = true           -- Allow unsaved background buffers
vim.wo.cursorline = true      -- Highlight current line
vim.wo.number = true          -- Show line numbers
vim.wo.relativenumber = true  -- Show relative line numbers
vim.o.joinspaces = false      -- Use one space afer punctuation
vim.o.scrolloff = 3           -- More context when scrolling off end of buffer

-- Open new split panes to right and bottom
vim.o.splitbelow = true
vim.o.splitright = true

-- Enhanced tab completion
vim.o.wildmode = 'list:longest,list:full'

-- Make searches case-sensitive only if they contain upper-case characters
vim.o.ignorecase = true
vim.o.smartcase = true

-- Softtabs, 2 spaces
vim.bo.tabstop = 2
vim.o.tabstop = 2
vim.bo.shiftwidth = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.bo.expandtab = true
vim.o.expandtab = true

-- coc.nvim recommends this be lowered from the default (4000ms) to improve
-- responsiveness and user experience
vim.o.updatetime = 300


-- Don't pass messages to |ins-completion-menu|.
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Highlight where 80 characters is
vim.wo.colorcolumn = '81'

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.wo.signcolumn = 'number'


-- Show effects of commands incrementally
vim.o.inccommand= 'nosplit'

-- Disable swapfiles
vim.o.swapfile = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- Colours
vim.o.termguicolors = true
vim.g.colors_name = 'gruvbox'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_sign_column = 'bg0'

-- ===========================================================================
-- Mappings
-- ===========================================================================

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ','

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
  }
}

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
      {'diagnostics',  sources = {'nvim_lsp', 'coc'},
        icons_enabled = false, color_error = '#cc241d',
        color_warn = '#d65d0e', color_info = '#458588'},
      'encoding',
      {'fileformat', icons_enabled = false},
      'filetype'
    }
  }
}
