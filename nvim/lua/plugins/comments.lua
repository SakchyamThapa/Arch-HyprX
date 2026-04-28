--------------------------------------------------------------------
--- Todo Comments: Highlight and navigate custom dev comments
--------------------------------------------------------------------
return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    local keymap = vim.keymap

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    -- Custom dev-focused comments
    todo_comments.setup({
      keywords = {
        DEVNOTE = { icon = "🛠", color = "warning", alt = { "NOTEFORDEV" } },
        CHECKME = { icon = "🔍", color = "info" },
        REFACTOR = { icon = "🔧", color = "hint" },
        DEBUG = { icon = "🐞", color = "error" },
        REVIEW = { icon = "👀", color = "info" },
        DEPRECATED = { icon = "⚠️", color = "warning" },
      },
    })
  end,
}

-- Optional: Use `<leader>ft` to open the list of all TODOs
-- Keywords handled: DEVNOTE, CHECKME, REFACTOR, DEBUG, REVIEW, DEPRECATED
