--------------------------------------------------------------------
--- syntax highlighting and code parsing
--------------------------------------------------------------------
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "python",
      "lua",
      "vim",
      "vimdoc",
      "bash",
    },
  },
}
