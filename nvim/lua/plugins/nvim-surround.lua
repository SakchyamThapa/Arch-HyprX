--------------------------------------------------------------------
-- Surround text objects easily
--------------------------------------------------------------------
return {
  "kylechui/nvim-surround",
  version = "^3.0.0",
  event = "BufReadPost",
  config = function()
    require("nvim-surround").setup({})
  end,
}
