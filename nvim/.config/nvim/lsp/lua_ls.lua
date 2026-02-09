return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "Snacks" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
      },
    },
  },
}
