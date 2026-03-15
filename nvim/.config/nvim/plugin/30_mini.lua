local now, later = Config.now, Config.later

now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require("mini.icons").setup({
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })
  Config.later(require("mini.icons").mock_nvim_web_devicons)
end)

later(function()
  require("mini.ai").setup()
end)

later(function()
  require("mini.align").setup()
end)

later(function()
  require("mini.bufremove").setup()
end)

later(function()
  require("mini.move").setup()
end)

later(function()
  require("mini.snippets").setup({
    snippets = {
      require("mini.snippets").gen_loader.from_lang(),
    },
  })
end)

later(function()
  require("mini.surround").setup()
end)
