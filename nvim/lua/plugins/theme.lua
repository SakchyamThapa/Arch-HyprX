--------------------------------------------------------------------
--- Oxocarbon Theme
--------------------------------------------------------------------
-- return {
--   {
--     "nyoom-engineering/oxocarbon.nvim",
--     priority = 1000,
--     config = function()
--       vim.o.termguicolors = true
--       vim.o.background = "dark"

--       vim.g.oxocarbon_lua_italics = true

--       vim.cmd.colorscheme("oxocarbon")
--     end,
--   },
-- }
--------------------------------------------------------------------
--- Catppuccin Theme (Mocha)
--------------------------------------------------------------------
-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--       vim.o.termguicolors = true
--       vim.o.background = "dark"

--       require("catppuccin").setup({
--         flavour = "macchiato", -- latte, frappe, macchiato, mocha
--         background = {
--           light = "latte",
--           dark = "mocha",
--         },
--         transparent_background = false,
--         show_end_of_buffer = false,
--         term_colors = true,
--         dim_inactive = {
--           enabled = false,
--         },
--         styles = {
--           comments = { "italic" },
--           conditionals = {},
--           loops = {},
--           functions = {},
--           keywords = {},
--           strings = {},
--           variables = {},
--           numbers = {},
--           booleans = {},
--           properties = {},
--           types = {},
--           operators = {},
--         },
--         integrations = {
--           treesitter = true,
--           native_lsp = {
--             enabled = true,
--           },
--           telescope = true,
--           cmp = true,
--           gitsigns = true,
--         },
--       })

--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }
--------------------------------------------------------------------
---Ever Forest
--------------------------------------------------------------------
return {
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"

      -- can set the background to -> soft, medium, hard
      vim.g.everforest_background = "medium"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_better_performance = 1

      vim.cmd.colorscheme("everforest")
    end,
  },
}

--------------------------------------------------------------------
---End of Ever Forest
--------------------------------------------------------------------

--------------------------------------------------------------------
--- gruvbox Theme
--------------------------------------------------------------------
-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     config = function()
--       vim.o.termguicolors = true
--       vim.o.background = "dark"
--
--       require("gruvbox").setup({
--         contrast = "hard",
--         italic = {
--           strings = false,
--           comments = true,
--           operators = false,
--           folds = true,
--         },
--         overrides = {},
--       })
--
--       -- apply colorscheme
--       vim.cmd.colorscheme("gruvbox")
--     end,
--   },
-- }
--
