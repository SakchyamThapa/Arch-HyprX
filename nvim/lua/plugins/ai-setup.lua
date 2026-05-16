--------------------------------------------------------------------
--- minimal Copilot setup for Neovim
--------------------------------------------------------------------
return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
          },
        },
        panel = { enabled = false },
        filetypes = { ["*"] = true },
      })
    end,
  },
}