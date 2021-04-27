local sorters = require 'telescope.sorters'
local builtin = require 'telescope.builtin'

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = require('telescope.actions').close
            }
        },
        prompt = '',
        color_devicons = true,
        initial_mode = 'insert',
        sorting_strategy = "ascending",
        layout_strategy = "center",
        results_title = false,
        preview_title = "Preview",
        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
        width = 80,
        results_height = 15,
        winbled = 10,
        file_sorter = sorters.get_fzy_sorter,
    }
}

vimp.nnoremap({'silent'}, '<C-P>', builtin.find_files)
vimp.nnoremap({'silent'}, '<C-F>', builtin.live_grep)
vimp.nnoremap({'silent'}, '<leader>lt', function() builtin.grep_string({search = 'TODO:'}) end)

