return {
    "nvim-tree/nvim-tree.lua",
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        vim.cmd([[ highlight NvimTreeIndentMarker guifg=#A6DA95 ]])

        -- configure nvim-tree
        nvimtree.setup({
            disable_netrw = false,
            hijack_cursor = false,
            hijack_netrw = false,
            hijack_unnamed_buffer_when_opening = false,
            reload_on_bufenter = false,
            sort_by = "case_sensitive",

            view = {
                adaptive_size = true,
            },
            -- change folder arrow icons
            renderer = {
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "", -- arrow when folder is closed
                            arrow_open = "", -- arrow when folder is open
                        },
                    },
                },
            },
            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
                dotfiles = true,
            },
            git = {
                ignore = false,
            },
        })
    end,
}
