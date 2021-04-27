local gl = require('galaxyline')
local gls = gl.section
local conds = require('galaxyline.condition')

local color = require("xresources")

local colors = {
    n = "blue",
    i = "green",
    c = "yellow",
    v = "cyan",
    V = "cyan",
    [''] = "cyan",
    R = "red",
    Rv = "red",
    ['?'] = "magenta"
}
local function get_light_color()
    return color['light_'..(colors[vim.fn.mode() or '?'])]
end

local function get_color()
    return color[(colors[vim.fn.mode() or '?'])]
end

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

-- highlight('StatusLine', 'none', 'none')

gls.left = {
    {
        ViMode = {
            provider = function()
                local alias ={n = 'N', i = 'I', c = 'C', v = 'V', V = 'VL', [''] = 'VB', R = 'R', Rv = 'RV'}
                highlight('GalaxyViMode', color.bg, get_color(), 'bold')
                highlight('GalaxyViModeInv', get_color(), conds.buffer_not_empty() and get_light_color() or 'NONE', 'bold')
                return "  " .. (alias[vim.fn.mode()] or '?') .. " "
            end,
            separator = '',
            separator_highlight = "GalaxyViModeInv"
        }
    },
    {
        CustomGitBranch = {
            provider = function()
                highlight('GalaxyDiff', color.bg, get_light_color(), 'bold')
                highlight('GalaxyDiffInv', get_light_color(), color.bg, 'bold')

                local filename = require('galaxyline.provider_fileinfo').get_current_file_name()
                local branch = require('galaxyline.provider_vcs').get_git_branch()

                if conds.check_git_workspace() or not branch then return " " .. filename .. " " end
                return (" " .. filename .. " @ " .. branch .. " ")
            end,
            condition = conds.buffer_not_empty,
            separator = '',
            highlight = 'GalaxyDiff',
            separator_highlight = 'GalaxyDiffInv'
        }
    },
    {
        DiffAdd = {
            provider = "DiffAdd",
            icon = "+",
            highlight = {color.blue, color.bg},
        }
    },
    {
        DiffRemove = {
            provider = "DiffRemove",
            icon = "-",
            highlight = {color.red, color.bg}
        }
    },
    {
        DiffModified = {
            provider = "DiffModified",
            icon = "~",
            highlight = {color.green, color.bg}
        }
    },

}

gls.right = {

    {
        Hints = {
            provider = function()
                highlight('GalaxyHints', color.bg, color.cyan, 'bold')
                highlight('GalaxyHintsInv', color.cyan, 'NONE', 'bold')
                local hints = require("galaxyline.provider_diagnostic").get_diagnostic_hint()
                if not hints then return "" end
                return " " .. hints
            end,
            separator = '',
            condition = conds.buffer_not_empty,
            highlight = 'GalaxyHints',
            separator_highlight = 'GalaxyHintsInv'
        }
    },
    {
        Warns = {
            provider = function()
                highlight('GalaxyWarns', color.bg, color.yellow, 'bold')
                highlight('GalaxyWarnsInv', color.yellow, color.cyan, 'bold')
                local hints = require("galaxyline.provider_diagnostic").get_diagnostic_warn()
                if not hints then return "" end
                return " " .. hints
            end,
            separator = '',
            condition = conds.buffer_not_empty,
            highlight = 'GalaxyWarns',
            separator_highlight = 'GalaxyWarnsInv'
        }
    },
    {
        Errors = {
            provider = function()
                highlight('GalaxyErrors', color.bg, color.red, 'bold')
                highlight('GalaxyErrorsInv', color.red, color.yellow, 'bold')
                local error = require("galaxyline.provider_diagnostic").get_diagnostic_error()
                if not error then return "" end
                return " " .. error
            end,
            separator = '',
            condition = conds.buffer_not_empty,
            highlight = 'GalaxyErrors',
            separator_highlight = 'GalaxyErrorsInv'
        }
    },
    {
        FileType = {
            provider = function()
                highlight('GalaxyIconFile', color.bg, get_color(), 'bold')
                highlight('GalaxyIconFileInv', get_color(), color.red, 'bold')
                return " " .. require("galaxyline.provider_fileinfo").get_file_icon()
            end,
            separator = '',
            condition = conds.buffer_not_empty,
            highlight = 'GalaxyIconFile',
            separator_highlight = 'GalaxyIconFileInv'
        }
    },

}
