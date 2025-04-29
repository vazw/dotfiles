return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    keys = {
      {
        "gD",
        function()
          vim.lsp.buf.declaration()
        end,
        desc = "Go To Declaration",
      },
      {
        "gd",
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Go To Definition",
      },
      {
        "K",
        function()
          vim.lsp.buf.hover()
        end,
        desc = "Lsp Hover",
      },
      {
        "<c-k>",
        function()
          vim.diagnostic.open_float()
        end,
        desc = "Diagnostic",
      },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            priority = 1,
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.HINT] = "󰠠 ",
              [vim.diagnostic.severity.INFO] = " ",
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {

          cssls = {},
          vtsls = { enabled = true },
          rust_analyzer = {},
          tailwindcss = {
            root_dir = function(...)
              return require("lspconfig.util").root_pattern("tailwind.config.js")(...)
            end,
            -- exclude a filetype from the default_config
            filetypes_exclude = { "markdown" },
            -- add additional filetypes to the default_config
            filetypes_include = { "rust" },
            -- to fully override the default_config, change the below
            -- filetypes = {}
            init_options = {
              userLanguages = {
                rust = "html",
                ["*.rs"] = "html",
              },
              tailwindCSS = {
                includeLanguages = {
                  rust = "html",
                  ["*.rs"] = "html",
                },
              },
            },
          },

          tsserver = {
            enabled = false,
            -- root_dir = function(...)
            --   return require("lspconfig.util").root_pattern(".git")(...)
            -- end,
            -- single_file_support = false,
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          },

          html = {},
          phpactor = {
            enabled = true,
          },
          gradle_ls = {},
          yamlls = {
            settings = {
              yaml = {
                keyOrdering = false,
              },
            },
          },

          lua_ls = {
            -- enabled = false,
            single_file_support = true,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                completion = {
                  workspaceWord = true,
                  callSnippet = "Both",
                },
                misc = {
                  parameters = {
                    -- "--log-level=trace",
                  },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
                doc = {
                  privateName = { "^_" },
                },
                type = {
                  castNumberToInteger = true,
                },
                diagnostics = {
                  globals = { "vim", "require" },
                  disable = { "incomplete-signature-doc", "trailing-space" },
                  -- enable = false,
                  groupSeverity = {
                    strong = "Warning",
                    strict = "Warning",
                  },
                  groupFileStatus = {
                    ["ambiguity"] = "Opened",
                    ["await"] = "Opened",
                    ["codestyle"] = "None",
                    ["duplicate"] = "Opened",
                    ["global"] = "Opened",
                    ["luadoc"] = "Opened",
                    ["redefined"] = "Opened",
                    ["strict"] = "Opened",
                    ["strong"] = "Opened",
                    ["type-check"] = "Opened",
                    ["unbalanced"] = "Opened",
                    ["unused"] = "Opened",
                  },
                  unusedLocalExclude = { "_*" },
                },
                format = {
                  enable = false,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent_size = "2",
                  },
                },
              },
            },
          },
        },
      }
      return ret
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
