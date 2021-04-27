local lsp = require 'lspconfig'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

vim.cmd [[
    hi LspDiagnosticsVirtualTextError gui=undercurl
]]

-- TODO: Move from here, makes no sense
local on_attach = function(client, bufnr)
    Opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[au BufWritePre <buffer> lua vim.lsp.buf.formatting()]]
    elseif client.resolved_capabilities.document_range_formatting then
        vim.api.nvim_command [[au BufWritePre <buffer> lua vim.lsp.buf.range_formatting()]]
    end

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local servers_config = {
    ["sumneko_lua"] = {
        cmd = {'lua-language-server'},
        settings = {
            Lua = {
                runtime = {
                    version = '5.4',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    enable = true,
                    globals = {
                        'vim',
                        'vimp',
                        'packer',
                        'awesome',
                        'client',
                        'root',
                    },
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        ['/usr/share/awesome/lib'] = true
                    },
                },
            }
        }
    }
}

local servers = {'sumneko_lua', 'gopls', 'rust_analyzer', 'svelte', 'tsserver'}
for _, server in pairs(servers) do
    local config = make_config()
    if servers_config[server] then config = vim.tbl_extend('error', config, servers_config[server]) end
    lsp[server].setup(config)
end
