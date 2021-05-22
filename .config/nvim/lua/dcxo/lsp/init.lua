vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "single"
    }
)
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--     vim.lsp.handlers.signature_help,
--     {
--       border = "single"
--     }
-- )


require('dcxo.lsp.servers')
require('dcxo.lsp.tools')

require('compe').setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = true;
        tags = true;
        snippets_nvim = true;
        treesitter = true;
    };
}
