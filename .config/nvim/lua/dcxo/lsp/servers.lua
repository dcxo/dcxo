local lsp = require 'lspconfig'

-- TODO: Move from here, makes no sense
local on_attach = function(client, bufnr)

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
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }
  return {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local pid = vim.fn.getpid()
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
    },
    [ 'java_language_server'] = {
        cmd = {'java-language-server'}
    },
    ['omnisharp'] = {
        cmd = { '/usr/bin/omnisharp', "--languageserver" , "--hostPID", tostring(pid) };
    }
}

local servers = {'sumneko_lua', 'gopls', 'rust_analyzer', 'svelte', 'tsserver', 'clangd', 'java_language_server', 'kotlin_language_server', 'omnisharp'}
for _, server in pairs(servers) do
    local config = make_config()
    if servers_config[server] then config = vim.tbl_extend('error', config, servers_config[server]) end
    lsp[server].setup(config)
end
require("lsp_signature").on_attach()
