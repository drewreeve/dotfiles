-- ===========================================================================
-- Global Mappings
-- ===========================================================================

local set = vim.keymap.set

-- Clear highlighted searches
set("n", "<leader>c", ":nohlsearch<CR>", { silent = true })

-- Switch between last 2 files
set("n", "<leader><leader>", "<C-^>")

-- Move around splits with <c-hjkl>
set("n", "<C-h>", "<C-w>h", { silent = true })
set("n", "<C-j>", "<C-w>j", { silent = true })
set("n", "<C-k>", "<C-w>k", { silent = true })
set("n", "<C-l>", "<C-w>l", { silent = true })

-- Diagnostics
set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "[S]how [D]iagnostics" })

-- These are mapped by default in neovim 0.10 but for some reason they don't
-- show the diagnostic float when you use them.
set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
