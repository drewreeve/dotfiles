local function map(mode, lhs, rhs, opts)
  local options = {}

  -- Check if opts is a string (shorthand for description)
  -- or a table (full options)
  if type(opts) == "string" then
    options.desc = opts
  elseif type(opts) == "table" then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

-- Clear highlighted searches
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Switch between last 2 files
map("n", "<leader><leader>", "<C-^>")

-- Move around splits with <c-hjkl>
map("n", "<C-h>", "<C-w>h", { silent = true })
map("n", "<C-j>", "<C-w>j", { silent = true })
map("n", "<C-k>", "<C-w>k", { silent = true })
map("n", "<C-l>", "<C-w>l", { silent = true })

-- Diagnostics
-- map("n", "<leader>sd", vim.diagnostic.open_float, "[S]how [D]iagnostics")

-- LSP
map("n", "<leader>h", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay [H]ints Enabled" or "Inlay Hints Disabled")
end, "Toggle Inlay [H]ints")

-- Packages
map("n", "<leader>vpu", "<Cmd>lua vim.pack.update()<CR>", "Update Plugins")
map("n", "<leader>vpd", function()
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
end, "Delete inactive plugins")

-- stylua: ignore start
map("n", "<leader>/", function() Snacks.picker.grep({ hidden = true }) end, "Grep")
map("n","<leader>:", function() Snacks.picker.command_history() end, "Command History")

-- Find
map("n", "<C-p>", function() Snacks.picker.files({ hidden = true }) end, "[F]ind [F]iles")
map("n", "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, "[F]ind [F]iles")
map("n", "<leader>fg", function() Snacks.picker.git_files() end, "[F]ind [G]it Files")

-- Grep
map("n", "<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, "Grep Open Buffers")
map("n", "<leader>sg", function() Snacks.picker.grep() end, "Grep")
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, "Visual selection or word")

-- Search
map("n", '<leader>s/', function() Snacks.picker.search_history() end, "Search History")
map("n", "<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
map("n", "<leader>sc", function() Snacks.picker.command_history() end, "Command History")
map("n", "<leader>sC", function() Snacks.picker.commands() end, "Commands")
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, "Diagnostics")
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
map("n", "<leader>sh", function() Snacks.picker.help() end, "Help Pages")
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, "Keymaps")
map("n", "<leader>sM", function() Snacks.picker.man() end, "Man Pages")
map("n", "<leader>sq", function() Snacks.picker.qflist() end, "Quickfix List")
map("n", "<leader>sR", function() Snacks.picker.resume() end, "Resume")
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, "Colorschemes")

-- LSP
map("n", "gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
map("n", "gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
map("n", "gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")
-- stylua: ignore end

-- NeoTest
-- stylua: ignore start
map("n", "<leader>ta", function() require("neotest").run.attach() end, "Attach to Test (Neotest)")
map("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, "Run File (Neotest)")
map("n", "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, "Run All Test Files (Neotest)")
map("n", "<leader>tr", function() require("neotest").run.run() end, "Run Nearest (Neotest)")
map("n", "<leader>tl", function() require("neotest").run.run_last() end, "Run Last (Neotest)")
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, "Toggle Summary (Neotest)")
map("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, "Show Output (Neotest)")
map("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, "Toggle Output Panel (Neotest)")
map("n", "<leader>tS", function() require("neotest").run.stop() end, "Stop (Neotest)")
map("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, "Toggle Watch (Neotest)")
-- stylua: ignore end

-- Oil
map("n", "-", "<CMD>Oil<CR>", "Open parent directory")
