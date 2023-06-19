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
