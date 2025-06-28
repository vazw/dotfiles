return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = true,
    event = "VeryLazy",
    config = function()
      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
      local configs = require("nvim-treesitter.configs")
      for name, fn in pairs(move) do
        if name:find("goto") == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find("[%]%[][cC]") then
                  vim.cmd("normal! " .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    priority = 1000,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")
      -- require("ts_context_commentstring").setup({})
      -- configure treesitter
      ---@diagnostic disable-next-line: missing-fields
      treesitter.setup({
        -- enable syntax highlighting

        highlight = {
          enable = false,
        },
        -- enable indentation
        indent = { enable = true },

        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "printf",
          "python",
          "query",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        -- auto install above language parsers
        auto_install = true,
        textobjects = {
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = { query = "@function.outer", desc = "Peek Definition Code" },
              ["<leader>dF"] = { query = "@class.outer", desc = "Peek Definition Code" },
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },

          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = { query = "@parameter.inner", desc = "Swap next" },
            },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "Swap previous" },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next Function Start" },
              ["]]"] = { query = "@class.outer", desc = "Next Class Start" },
              ["]o"] = { query = "@loop.*", desc = "Select Loop" },
              ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Goto Next Function End" },
              ["]["] = { query = "@class.outer", desc = "Goto Next Class End" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Goto Previous Function Start" },
              ["[["] = { query = "@class.outer", desc = "Goto Previous Class Start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Goto Previous Function End" },
              ["[]"] = { query = "@class.outer", desc = "Goto Previous Class End" },
            },
            goto_next = {
              ["]d"] = { query = "@conditional.outer", desc = "Goto Next Node" },
            },
            goto_previous = {
              ["[d"] = { query = "@conditional.outer", desc = "Goto Previous Node" },
            },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    opts = {
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "rayliwell/tree-sitter-rstml",
    enabled = true,
    dependencies = { "nvim-treesitter" },
    build = ":TSUpdate",
    ft = { "rust" },
    config = function()
      require("tree-sitter-rstml").setup()
    end,
  },
}
