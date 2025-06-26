return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    {
      'echasnovski/mini.icons',
      version = '*',
      config = function()
        local MiniIcons = require("mini.icons")
        MiniIcons.setup({
          file = {
            [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
            ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
          },
          filetype = {
            dotenv = { glyph = "", hl = "MiniIconsYellow" },
          },
        })
        MiniIcons.mock_nvim_web_devicons()
        MiniIcons.tweak_lsp_kind("replace")
      end
    },
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = vim.o.laststatus == 3,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰠠 " },
            colored = true,
            update_in_insert = true,
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            file_status = true,    -- Displays file status (readonly status, modified status)
            newfile_status = true, -- Display new file status (new file means no write after created)
            path = 4,
            symbols = {
              modified = "",
              readonly = "󰷊",
              unnamed = "󰩋[unnamed]",
              newfile = "",
            },
            padding = { left = 0, right = 1 }
          },
        },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
          },
          { "encoding", separator = "", padding = 1, icon = { '[Encoding]', align = 'left' } },
          {
            'fileformat',
            symbols = {
              unix = 'unix', -- e712
              dos = 'dos', -- e70f
              mac = '', -- e711
            },
            icon = { '[EOL]', align = 'left' },
            padding = { left = 0, right = 1 }
          }
        },
        lualine_y = {
          {
            "lsp_status",
            icon = "",
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              -- Standard unicode symbol for when LSP is done:
              done = "✓",
              -- Delimiter inserted between LSP names:
              separator = " ",
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = { "null-ls", "typos_lsp" },
          },
        },
        lualine_z = {
          { "progress", separator = "", padding = 0 },
          "location",
        },
      },
      extensions = { "lazy" },
    })
  end,
}
