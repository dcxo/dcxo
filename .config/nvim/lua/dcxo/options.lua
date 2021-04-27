Opt.backup = false
Opt.completeopt = 'noinsert,noselect,menu,menuone'
Opt.cursorline = true
Opt.expandtab = true
Opt.foldexpr = 'nvim_treesitter#foldexpr()'
Opt.foldlevelstart = 300
Opt.foldmethod = 'expr'
Opt.foldmethod = 'syntax'
Opt.hidden = true
Opt.linebreak = true
Opt.list = true
Opt.listchars = 'tab:|  ,space:·,eol:'
Opt.mouse = 'a'
Opt.number = true
Opt.relativenumber = true
Opt.shiftwidth = 4
Opt.shortmess = vim.o.shortmess .. 'c'
Opt.shortmess = vim.o.shortmess:gsub('F', '')
Opt.showmode = false
Opt.signcolumn = 'yes:1'
Opt.tabstop = 4
Opt.textwidth = 0
Opt.updatetime = 100
Opt.wrap = true
Opt.wrapmargin = 0
Opt.writebackup = false
Opt.autowriteall = true

vim.g.mapleader  =  ' '

vim.api.nvim_exec([[
    augroup RelNumbers
        autocmd!
        autocmd InsertEnter * set norelativenumber
        autocmd InsertLeave * set relativenumber
    augroup END
        augroup VimGroup
        autocmd!
        au BufWritePre * %s/\s\+$//e
    augroup end
]], false)
