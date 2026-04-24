-- Spell checking and text completion configuration
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

-- Enable spell checking for text files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex", "*.rst", "gitcommit" },
  callback = function()
    vim.opt_local.spell = false
    vim.opt_local.complete:append("kspell") -- Add spell completion
  end,
})

-- Keymaps for spell checking
vim.keymap.set("n", "]s", "]s", { desc = "Next misspelled word" })
vim.keymap.set("n", "[s", "[s", { desc = "Previous misspelled word" })
vim.keymap.set("n", "z=", "z=", { desc = "Suggest corrections" })
vim.keymap.set("n", "zg", "zg", { desc = "Add word to dictionary" })
vim.keymap.set("n", "zw", "zw", { desc = "Mark word as wrong" })