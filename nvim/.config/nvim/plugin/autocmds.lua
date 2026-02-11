-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Auto jump to last position",
  group = vim.api.nvim_create_augroup("auto-last-position", { clear = true }),
  callback = function(event)
    local exclude_ft = { "gitcommit" }
    local buf = event.buf

    if vim.tbl_contains(exclude_ft, vim.bo[buf].filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local line_count = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create dir when saving files
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})
