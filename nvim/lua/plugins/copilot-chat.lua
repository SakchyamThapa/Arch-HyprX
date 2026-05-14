--------------------------------------------------------------------
--- Copilot Chat for Neovim
--------------------------------------------------------------------
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    opts = {
      question_header = "󰭤 Ask ",
      answer_header = "󰳌 Copilot ",
      chat_header = "󰚔 Copilot Chat ",
    },
    keys = {
      { "<leader>cp", ":CopilotChat<CR>", desc = "Open Copilot Chat" },
      { "<leader>ce", ":CopilotChatExplain<CR>", desc = "Explain code" },
      { "<leader>cf", ":CopilotChatFix<CR>", desc = "Fix code" },
      { "<leader>cr", ":CopilotChatReview<CR>", desc = "Review code" },
    },
  },
}