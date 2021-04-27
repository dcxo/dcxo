local builtin = require('telescope.builtin')

vim.api.nvim_exec([[
imap <silent> <C-Space> <c-x><c-o>

nnoremap <SPACE> <Nop>

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
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
