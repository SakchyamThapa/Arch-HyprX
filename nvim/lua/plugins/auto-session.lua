--------------------------------------------------------------------
--- Auto Session: Automatically save and restore Neovim sessions
--------------------------------------------------------------------
return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    vim.opt.sessionoptions = "buffers,curdir,tabpages,winsize,folds,help,globals,localoptions"

    require("auto-session").setup({
      enabled = true,
      auto_save = true,
      auto_restore = false,
      auto_create = true,
      auto_restore_last_session = false,

      legacy_cmds = true,

      suppressed_dirs = { "/tmp", "/var" },
      allowed_dirs = nil,

      bypass_save_filetypes = { "gitcommit", "dashboard" },
      close_filetypes_on_save = { "checkhealth" },
      close_unsupported_windows = true,

      root_dir = vim.fn.stdpath("data") .. "/sessions/",

      show_auto_restore_notif = false,
      log_level = "info",

      lazy_support = true,

      continue_restore_on_error = false,

      pre_save_cmds = { "tabdo windo wincmd =" },
    })

    vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save Session" })
    vim.keymap.set("n", "<leader>sl", "<cmd>SessionRestore<CR>", { desc = "Restore Session" })
    vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete Session" })
  end,
}
--
--

--------------------------------------------------------------------
---this commented doesn't work multiple split windows
--------------------------------------------------------------------
-- return {
--   "rmagatti/auto-session",
--   lazy = false, -- Load immediately instead of VeryLazy
--   config = function()
--     vim.opt.sessionoptions:append("localoptions")
--
--     require("auto-session").setup({
--       enabled = true, -- enable auto-session
--       auto_save = true, -- automatically save sessions on exit
--       auto_restore = false, -- disable auto restore on startup
--       auto_create = true, -- allow new session creation
--       auto_restore_last_session = false, -- don't restore last session automatically
--
--       legacy_cmds = true, -- defines :SaveSession, :RestoreSession, :DeleteSession
--
--       -- Directories to ignore/allow
--       suppressed_dirs = { "/tmp", "/var" },
--       allowed_dirs = nil,
--
--       -- Buffers to ignore
--       bypass_save_filetypes = { "gitcommit", "dashboard" },
--       close_filetypes_on_save = { "checkhealth" },
--       close_unsupported_windows = true,
--
--       -- Session storage
--       root_dir = vim.fn.stdpath("data") .. "/sessions/",
--
--       -- Notifications & logging
--       show_auto_restore_notif = false,
--       log_level = "info",
--
--       -- LazyVim support
--       lazy_support = true,
--
--       -- Error handling
--       continue_restore_on_error = false,
--     })
--
--     -- Keymaps for manual session control
--     vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save Session" })
--     vim.keymap.set("n", "<leader>sl", "<cmd>SessionRestore<CR>", { desc = "Restore Session" })
--     vim.keymap.set("n", "<leader>sd", "<cmd>SessionDelete<CR>", { desc = "Delete Session" })
--   end,
-- }
