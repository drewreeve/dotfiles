-- ===========================================================================
-- Global Mappings
-- ===========================================================================

-- Clear highlighted searches
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { silent = true })

-- Switch between last 2 files
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Move around splits with <c-hjkl>
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })
