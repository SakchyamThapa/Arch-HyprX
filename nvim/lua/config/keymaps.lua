--------------------------------------------------------------------
--- Custom Keymaps
--- Clustered by mode and functionality
--------------------------------------------------------------------

local builtin = require("telescope.builtin")
local telescope = require("telescope")
local keymap = vim.keymap

-- =========================
-- Insert Mode
-- =========================

-- jk to escape insert mode quickly
keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.opt.timeoutlen = 200 -- must type jk quickly

-- =========================
-- Normal Mode: Window Navigation
-- =========================

keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Ctrl+1 to Ctrl+9 to focus specific window/buffer
for i = 1, 9 do
  keymap.set("n", "<C-" .. i .. ">", i .. "<C-w>w", { desc = "Focus window " .. i })
end

-- =========================
-- Normal Mode: Buffer Management
-- =========================

-- Close all other buffers safely
keymap.set("n", "<C-x>", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf ~= current and buf_type == "" and buf_name ~= "" then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end, { desc = "Close all other buffers safely", silent = true })

-- =========================
-- Normal Mode: Telescope / Fuzzy Finder
-- =========================

local telescope_maps = {
  ["<C-p>"] = { builtin.find_files, "Fuzzy find files" },
  ["<C-g>"] = { builtin.live_grep, "Grep text in project" },
  ["\\"] = { builtin.buffers, "List open buffers" },
}

for k, v in pairs(telescope_maps) do
  keymap.set("n", k, v[1], { desc = v[2] })
end

-- Telescope File Browser
keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = vim.fn.expand("%:p:h"),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end, { desc = "Open Telescope File Browser" })

-- =========================
-- Normal Mode: Diagnostics
-- =========================

keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show error under cursor" })
keymap.set("n", "<leader>dl", function()
  vim.diagnostic.setloclist()
  vim.cmd("lopen")
end, { desc = "List all diagnostics in location list" })

-- =========================
-- Normal Mode: NvimTree
-- =========================

keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })

-- =========================
-- Normal Mode: TODO Comments
-- =========================

keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Search TODO comments" })

-- =========================
-- Normal Mode: Obsidian Vault
-- =========================

-- local vault_path = vim.fn.expand("~/dotfiles/obsidian/obs vault/")
--
-- keymap.set(
--   "n",
--   "<leader>on",
--   ":ObsidianTemplate note<CR>:lua.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<CR>",
--   { noremap = true, silent = true }
-- )
-- keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<CR>")
-- keymap.set("n", "<leader>os", function()
--   builtin.find_files({ search_dirs = { vault_path } })
-- end, { desc = "Find files in Obsidian vault" })
-- keymap.set("n", "<leader>oz", function()
--   builtin.live_grep({ search_dirs = { vault_path } })
-- end, { desc = "Live grep in Obsidian vault" })
-- keymap.set(
--   "n",
--   "<leader>ok",
--   ":!mv '%:p' ~/dotfiles/obsidian/obs\\ vault/zdebrix/<CR>:bd<CR>",
--   { noremap = true, silent = true, desc = "Move note to zdebrix" }
-- )
-- keymap.set("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>", { noremap = true, silent = true, desc = "Delete note" })
