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

-- LSP
set("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay [H]ints Enabled" or "Inlay Hints Disabled")
end)

-- Packages
set("n", "<leader>vpu", "<Cmd>lua vim.pack.update()", { desc = "Update Plugins" })
set("n", "<leader>vpd", function()
  local packages = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  vim.pack.del(packages)
end, { desc = "Delete inactive plugins" })

-- stylua: ignore start
set("n", "<leader>/", function() Snacks.picker.grep({ hidden = true }) end, { desc = "Grep" })
set("n","<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })

-- Find
set("n", "<C-p>", function() Snacks.picker.files({ hidden = true }) end, { desc = "[F]ind [F]iles" })
set("n", "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, { desc = "[F]ind [F]iles" })
set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "[F]ind [G]it Files" })

-- Grep
set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
set({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })

-- Search
set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
-- stylua: ignore end
