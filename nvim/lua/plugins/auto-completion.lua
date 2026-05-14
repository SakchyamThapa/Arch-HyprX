--------------------------------------------------------------------
-- Completion and LSP setup using blink.cmp, nvim-cmp (disabled), LuaSnip, and Mason
--------------------------------------------------------------------
return {
  { "hrsh7th/nvim-cmp", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },
  { "hrsh7th/cmp-buffer", enabled = false },
  { "hrsh7th/cmp-path", enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },

  {
    "saghen/blink.cmp",
    lazy = false,
    priority = 1000,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "v0.*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<CR>"] = { "accept", "fallback" },
          ["<C-y>"] = { "accept", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<Tab>"] = function(cmp)
            local ok, copilot = pcall(require, "copilot.suggestion")
            if ok and copilot.is_visible() then
              copilot.accept()
              return true
            end
          end,
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        completion = {
          accept = {
            auto_brackets = { enabled = true },
          },
          menu = {
            auto_show = true,
            border = "rounded",
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
        },
        signature = { enabled = true },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "pyright", "tsserver" },
      automatic_installation = true,
    },
  },
}
