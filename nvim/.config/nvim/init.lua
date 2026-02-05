--
-- Neovim settings/keymaps
--

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

vim.diagnostic.config({
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
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

--
-- Keymaps
--

vim.g.mapleader = " "

local set = vim.keymap.set

-- Clear highlighted searches
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Switch between last 2 files
set("n", "<leader><leader>", "<C-^>")

-- Move around splits with <c-hjkl>
set("n", "<C-h>", "<C-w>h", { silent = true })
set("n", "<C-j>", "<C-w>j", { silent = true })
set("n", "<C-k>", "<C-w>k", { silent = true })
set("n", "<C-l>", "<C-w>l", { silent = true })

-- Diagnostics
set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "[S]how [D]iagnostics" })
