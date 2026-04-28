--------------------------------------------------------------------
--- Incline: Floating file name at the right side
--------------------------------------------------------------------
return {
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim", "kyazdani42/nvim-web-devicons" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#2c2a29", guifg = "#a76d5d" },
            InclineNormalNC = { guibg = "#2c2a29", guifg = "#7f7f7f" },
          },
        },
        window = { margin = { vertical = 2, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  --------------------------------------------------------------------
  --- Snacks: Dashboard with ASCII header
  --------------------------------------------------------------------
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 ▄▄▄       █    ██  ██▀███   ▄▄▄      
▒████▄     ██  ▓██▒▓██ ▒ ██▒▒████▄    
▒██  ▀█▄  ▓██  ▒██░▓██ ░▄█ ▒▒██  ▀█▄  
░██▄▄▄▄██ ▓▓█  ░██░▒██▀▀█▄  ░██▄▄▄▄██ 
 ▓█   ▓██▒▒▒█████▓ ░██▓ ▒██▒ ▓█   ▓██▒
 ▒▒   ▓▒█░░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░
  ▒   ▒▒ ░░░▒░ ░ ░   ░▒ ░ ▒░  ▒   ▒▒ ░
  ░   ▒    ░░░ ░ ░   ░░   ░   ░   ▒   
      ░  ░   ░        ░           ░  ░
                                      
          
          ]],
        },
      },
    },
  },
}
