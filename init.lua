-- to enable this run nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "nightly", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
  },
  -- Set colorscheme to use
  colorscheme = "gruvbox",
  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      terraform_fmt_on_save = 1
    },
  },
  -- If you need more control, you can use the function()...end notation
  options = function(local_vim)
    -- vim.opt.iskeyword:append("-") equivalent:
    local_vim.opt.iskeyword = vim.opt.iskeyword + {"-"}-- consider string-string as whole word
    return local_vim
  end,

  header = {
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  -- Extend LSP configuration
  lsp = {
    skip_setup = { "rust-analyzer" }, -- skip lsp setup because rust-tools will do it itself
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      ["<leader>bn"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Cycle next tab" },
      ["<leader>bp"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle prev tab" },
      ["<leader>bl"] = { "<cmd>BufferLineCloseLeft<cr>", desc = "Close tabs to the left" },
      ["<leader>br"] = { "<cmd>BufferLineCloseRight<cr>", desc = "close tabs to the right" },
      -- mappints under group name "Rust/RestClient"
      ["<leader>rr"] = { "<Plug>RestNvim<cr>", desc = "Run request under cursor" },
      ["<leader>rp"] = { "<Plug>RestNvimPreview<cr>", desc = "Preview request cURL command" },
      ["<leader>rl"] = { "<Plug>RestNvimLast<cr>", desc = "Re-run last request" },
      ["<leader>rh"] = { "<cmd>RustHoverActions<cr>", desc = "Rust Hover Actions" },
      -- mappings under group name "Terraform/Terragrunt"
      ["<leader>Ti"] = { ":!terraform init --upgrade<CR>", desc = "Terraform init upgrade" },
      ["<leader>Tl"] = { ":!terraform providers lock -platform=linux_amd64 -platform=darwin_amd64<CR>", desc = "Terraform lock providers linux and mac" },
      ["<leader>Tf"] = { ":!terragrunt hclfmt<CR>", desc = "Terragrunt format" },
    },
  },
    -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
          ["r"] = { name = "Rust/RestClient" },
          ["T"] = { name = "Terraform/Terragrunt" },
        },
      },
    },
  },

  -- Configure plugins
  plugins = {
    init = {
      { "python-mode/python-mode" },
      { "hashivim/vim-terraform" },
      { "tpope/vim-surround" },
      { "vim-scripts/ReplaceWithRegister" }, -- replace with register contents using motion (gr + motion)
      {
        "simrat39/rust-tools.nvim",
        after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer", -- get the server settings and built in capabilities/on_attach
            tools = {
              autoSetHints = true,
              hover_actions = {
                auto_focus = true,
              },
            },
          }
          require("rust-tools").inlay_hints.enable()
        end,
      },
      {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function() require("catppuccin").setup {} end,
      },
      {
        "ellisonleao/gruvbox.nvim",
        as = "gruvbox",
        config = function()
          require("gruvbox").setup {
            overrides = {
              StatusLine = {
                bg = "#303030",
                fg = "#887d73",
              },
              NeoTreeGitModified = {
                bg = "#282828",
                fg = "#83a598",
              },
              NeoTreeGitAdded = {
                bg = "#282828",
                fg = "#91e043",
              },
              NeoTreeGitDeleted = {
                bg = "#282828",
                fg = "#fb4934",
              },
              NeoTreeGitIgnored = {
                bg = "#282828",
              },
            },
          }
        end,
      },
      {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
          require("rest-nvim").setup {
            result_split_horizontal = false,
            result_split_in_place = false,
            skip_ssl_verification = false,
            encode_url = true,
            highlight = {
              enabled = true,
              timeout = 150,
            },
            result = {
              show_url = true,
              show_http_info = true,
              show_headers = true,
              formatters = {
                json = "jq",
                -- html = function(body) return vim.fn.system({ "tidy", "-i", "-q", "-" }, body) end,
              },
            },
            jump_to_request = false,
            env_file = ".env",
            custom_dynamic_variables = {},
            yank_dry_run = true,
          }
        end,
      },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = {
        "lua",
        "python",
        "regex",
        "rust",
        "sql",
        "yaml",
        "http",
        "java",
        "hcl",
        "go",
        "bash",
        "c_sharp",
        "json",
        "json5",
      },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
        "pyright",
        "terraformls",
        "tflint",
        "bashls",
        "csharp_ls",
        "ansiblels",
        "gopls",
        "jsonls",
        "marksman",
        "yamlls"
      },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      ensure_installed = { 
        -- "prettier",
        "stylua",
        "pylint",
        "autopep8",
        "shellcheck",
        "shellharden",
        "shfmt",
        "markdownlint",
        "jq",
        "yamllint",
        "cfn_lint",
      },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config