local nvim_lsp = require('lspconfig')

local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local servers = {
  'ansiblels',
  'bashls',
  'cssls',
  'html',
  'jsonls',
  'pyright',
  'solargraph',
  'tsserver'
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

 -- Change to your sumneko root installation
local sumneko_root_path = vim.fn.getenv("HOME").."/build/lua-language-server"
-- Change to your OS specific output folder
local sumneko_binary_path = "/bin/Linux/lua-language-server"

nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_root_path .. sumneko_binary_path, "-E", sumneko_root_path.."/main.lua" };
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

nvim_lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"sh"},
  settings = {
    languages = {
      sh = {
        {
          LintCommand = 'shellcheck -f gcc -x',
          lintFormats = {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'},
          formatCommand = 'shfmt -ci -s -bn',
          formatStdin = true
        }
      }
    }
  }
}
