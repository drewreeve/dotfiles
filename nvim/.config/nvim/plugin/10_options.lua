vim.g.mapleader = " "

local opt = vim.opt

-- Editing
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.tabstop = 2 -- Tab = 2 spaces
opt.shiftwidth = 2 -- No. of spaces for indentation
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true
opt.spelloptions = "camel"
opt.virtualedit = "block"
opt.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
opt.formatoptions = "rqnl1j" -- Improve comment editing (taken from MiniMax)
local f = function()
  vim.cmd("setlocal formatoptions-=c formatoptions-=o")
end
Config.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")

-- Built-in completion
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.o.completetimeout = 100 -- Limit sources delay

-- UI
opt.breakindent = true -- Indent wrapped lines to match line start
opt.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
opt.colorcolumn = "+1"
opt.hidden = true -- Allow unsaved background buffers
opt.cursorline = true -- Highlight current line
opt.cursorlineopt = "screenline,number"
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.joinspaces = false -- Use one space afer punctuation
opt.scrolloff = 3 -- More context when scrolling off end of buffer
opt.splitbelow = true
opt.splitright = true
opt.pumborder = "single" -- Use border in popup menu
opt.pumheight = 12 -- Make popup menu smaller
opt.pummaxwidth = 100 -- Make popup menu not too wide
opt.winborder = "single"
opt.signcolumn = "yes" -- Always show signcolumn
opt.showmode = false
opt.shortmess:append("c")

-- Enhanced tab completion
opt.wildmode = { "list:longest", "list:full" }

opt.updatetime = 1000

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

opt.confirm = true
--
-- Diagnostic Config
--

local diagnostic_opts = {
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
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
