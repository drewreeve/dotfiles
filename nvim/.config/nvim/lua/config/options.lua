local opt = vim.opt

-- ===========================================================================
-- General settings
-- ===========================================================================

opt.hidden = true         -- Allow unsaved background buffers
opt.cursorline = true     -- Highlight current line
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.joinspaces = false    -- Use one space afer punctuation
opt.scrolloff = 3         -- More context when scrolling off end of buffer

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
opt.clipboard = "unnamedplus"
