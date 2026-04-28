--------------------------------------------------------------------
--- minimal Copilot setup for Neovim
--------------------------------------------------------------------
return {
  {
    "zbirenbaum/copilot.lua",
    -- event = "VeryLazy", --verylazy shows the suggestion everytime whereas insertenter shows only when entering insert mode
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = false },
        filetypes = { ["*"] = true },
      })

      vim.keymap.set("i", "<S-Tab>", function()
        local s = require("copilot.suggestion")
        if s.is_visible() then
          s.accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "i", false)
        end
      end, { silent = true })
    end,
  },
}
