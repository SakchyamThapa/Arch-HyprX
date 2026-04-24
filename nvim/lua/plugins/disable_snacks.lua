--------------------------------------------------------------------
--- Snacks: Disable file explorer and keymaps
--------------------------------------------------------------------
return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
    keys = {
      { "<leader>E", false },
      { "<C-e>", false },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
  },
}
