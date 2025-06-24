return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "moyiz/blink-emoji.nvim", "L3MON4D3/LuaSnip" },
    version = "1.*",
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        -- set to 'none' to disable the 'default' preset
        preset = "enter",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-Tab>"] = { "snippet_forward", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "inherit",
          ["<CR>"] = { "select_and_accept", "fallback" },
          ["<Tab>"] = {
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
            end,
            "show_and_insert",
            "select_next",
          },
          ["<S-Tab>"] = { "show_and_insert", "select_prev" },

          ["<C-space>"] = { "show", "fallback" },

          ["<C-n>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<Right>"] = { "select_next", "fallback" },
          ["<Left>"] = { "select_prev", "fallback" },

          ["<C-y>"] = { "select_and_accept" },
          ["<C-e>"] = { "cancel" },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        menu = {
          auto_show = true,
          winblend = vim.o.winblend,
        },
        documentation = {
          auto_show = true,
        },
        list = {
          cycle = {
            from_top = true,
            from_bottom = true,
          },
          selection = {
            auto_insert = true,
            -- or a function
            preselect = false,
          },
        },
        trigger = {
          show_on_keyword = true,
        },
        ghost_text = { enabled = true, show_with_menu = true },
      },
      signature = { enabled = true, window = { winblend = vim.o.winblend } },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "cmdline" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- Tune by preference
            opts = { insert = true }, -- Insert emoji (default) or complete its name
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for git commits and markdown.
                -- By default, enabled for all file-types.
                { "gitcommit", "markdown", "html" },
                vim.o.filetype
              )
            end,
          },
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",

            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information
            enabled = true, -- Whether or not to enable the provider
            async = false, -- Whether we should show the completions before this provider returns, without waiting for it
            timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
            transform_items = nil, -- Function to transform the items before they're returned
            should_show_items = true, -- Whether or not to show the items
            max_items = nil, -- Maximum number of items to display in the menu
            min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
            -- If this provider returns 0 items, it will fallback to these providers.
            -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
            fallbacks = {},
            score_offset = 0, -- Boost/penalize the score of the items
            override = nil, -- Override the source's functions
          },
        },
      },
      fuzzy = {
        implementation = "rust",
        sorts = {
          "score",
          "sort_text",
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
