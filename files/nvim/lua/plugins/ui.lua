return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    enabled = false,
    opts = function(_, opts)
      opts.presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = false,
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
    opts = {
      timeout = 5000,
    },
  },
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>?",
        function()
          vim.cmd("Telescope keymaps")
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    enabled = false,
    -- dependencies = { "craftzdog/solarized-osaka.nvim" },
    -- event = "BufReadPre",
    -- priority = 1200,
    -- config = function()
    --   local colors = require("solarized-osaka.colors").setup()
    --   require("incline").setup({
    --     highlight = {
    --       groups = {
    --         InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
    --         InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
    --       },
    --     },
    --     window = { margin = { vertical = 0, horizontal = 1 } },
    --     hide = {
    --       cursorline = true,
    --     },
    --     render = function(props)
    --       local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    --       if vim.bo[props.buf].modified then
    --         filename = "[+] " .. filename
    --       end
    --
    --       local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    --       return { { icon, guifg = color }, { " " }, { filename } }
    --     end,
    --   })
    -- end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
    ░██████╗██╗░█████╗░███╗░░░███╗ ██████╗░███████╗██╗░░░██╗
    ██╔════╝██║██╔══██╗████╗░████║ ██╔══██╗██╔════╝██║░░░██║
    ╚█████╗░██║███████║██╔████╔██║ ██║░░██║█████╗░░╚██╗░██╔╝
    ░╚═══██╗██║██╔══██║██║╚██╔╝██║ ██║░░██║██╔══╝░░░╚████╔╝░
    ██████╔╝██║██║░░██║██║░╚═╝░██║ ██████╔╝███████╗░░╚██╔╝░░
    ╚═════╝░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝ ╚═════╝░╚══════╝░░░╚═╝░░░
   ]],
        },
      },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      words = { enabled = false },
      explorer = { enabled = false },
    },
    keys = {
      { "<leader><space>", false },
      { "<leader>/", false },
    },
  },
}
