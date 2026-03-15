vim.g.mapleader = " "

local opt = vim.opt

opt.hidden = true -- Allow unsaved background buffers
opt.cursorline = true -- Highlight current line
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.joinspaces = false -- Use one space afer punctuation
opt.scrolloff = 3 -- More context when scrolling off end of buffer

-- Open new split panes to right and bottom
opt.splitbelow = true
opt.splitright = true

-- Enhanced tab completion
opt.wildmode = { "list:longest", "list:full" }

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
opt.colorcolumn = "81"

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = "yes"

-- Show effects of commands incrementally
opt.inccommand = "nosplit"

-- Disable swapfiles
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Colours
opt.termguicolors = true

-- Use system clipboard
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

vim.g.have_nerd_font = true

opt.confirm = true

--
-- Diagnostic Config
-- See :help vim.diagnostic.Opts
--
local diagnostic_opts = {
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    current_line = false,
  },
  virtual_lines = {
    current_line = true,
  },

  -- Don't update diagnostics when typing
  update_in_insert = false,
}

Config.later(function()
  vim.diagnostic.config(diagnostic_opts)
end)

--
-- Autocmds
--

-- Restore cursor to file position in previous editing session
Config.new_autocmd("BufReadPost", "*", function(ev)
  local exclude_ft = { "gitcommit" }
  local buf = ev.buf

  if vim.tbl_contains(exclude_ft, vim.bo[buf].filetype) then
    return
  end

  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  local line_count = vim.api.nvim_buf_line_count(buf)
  if mark[1] > 0 and mark[1] <= line_count then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end, "Auto jump to last position")

-- Auto create dir when saving files
Config.new_autocmd("BufWritePre", "*", function(ev)
  if ev.match:match("^%w%w+:[\\/][\\/]") then
    return
  end
  local file = vim.uv.fs_realpath(ev.match) or ev.match
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end, "Auto create dir on save")
