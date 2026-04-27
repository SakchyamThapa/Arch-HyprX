--------------------------------------------------------------------
--- Nvim-Tree: File Explorer
--------------------------------------------------------------------
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("nvim-tree").setup({
      sort_by = "name",
      hijack_netrw = true,
      update_cwd = true,

      view = {
        width = 40,
        side = "left",
        number = true,
        relativenumber = true,
        signcolumn = "no",
      },

      renderer = {
        group_empty = false,
        indent_markers = {
          enable = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
        },
        root_folder_modifier = ":t",
        add_trailing = false,
        highlight_git = true,
        highlight_diagnostics = false,
        indent_width = 2,
      },

      filters = {
        dotfiles = false,
      },

      git = {
        enable = true,
      },
    })
  end,
}
