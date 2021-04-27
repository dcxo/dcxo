require('nvim-web-devicons').setup {
}

local opts_info = vim.api.nvim_get_all_options_info()

Opt = setmetatable({}, {
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == 'win' then
      vim.wo[key] = value
    elseif scope == 'buf' then
      vim.bo[key] = value
    end
  end
})

require('vimp')

require('dcxo.options')
require('dcxo.plugins')
require('dcxo.telescope')
require('dcxo.keymaps')
require('dcxo.lsp')
require('dcxo.treesitter')
