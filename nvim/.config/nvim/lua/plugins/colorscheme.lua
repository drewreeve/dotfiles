return {
  {
    'gruvbox-community/gruvbox',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_italic = 1
      vim.g.gruvbox_sign_column = 'bg0'
      vim.cmd [[colorscheme gruvbox ]]
    end
  },
}
