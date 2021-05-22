local builtin = require('telescope.builtin')

vim.api.nvim_exec([[
nnoremap <silent> <Space> <Nop>
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
]], false)

-- LSP Related
vimp.nnoremap({'silent'}, '<F2>',      require('lspsaga.rename').rename)
vimp.nnoremap({'silent'}, 'gR',        builtin.lsp_references)
vimp.nnoremap({'silent'}, 'gd',        builtin.lsp_definitions)
vimp.nnoremap({'silent'}, 'gl',        require("lspsaga.diagnostic").lsp_jump_diagnostic_next)
vimp.nnoremap({'silent'}, 'gh',        require("lspsaga.diagnostic").lsp_jump_diagnostic_prev)
vimp.nnoremap({'silent'}, '<leader>s', builtin.lsp_document_symbols)
vimp.nnoremap({'silent'}, '<leader>S', function ()
    builtin.lsp_workspace_symbols({query = vim.fn.input("Search for symbols 🔍 "), })
end)
vimp.nnoremap({'silent'}, '<leader>a', require('lspsaga.codeaction').code_action)
vimp.vnoremap({'silent'}, '<leader>a', require('lspsaga.codeaction').range_code_action)
vimp.nnoremap({'silent'}, '<leader>d', builtin.lsp_document_diagnostics)
vimp.nnoremap({'silent'}, 'K',         require('lspsaga.hover').render_hover_doc)
vimp.nnoremap({'silent'}, '<leader>f', vim.lsp.buf.formatting)
vimp.imap("<C-Space>", "<c-x><c-o>")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
