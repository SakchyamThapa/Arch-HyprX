--------------------------------------------------------------------
--- Axle: Remote plugin
--------------------------------------------------------------------
return {
  "deb-debri3/Axle",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function() end,
}

--------------------------------------------------------------------
--- Axle: Local testing
--------------------------------------------------------------------
-- return {
--   dir = "/home/deb/Desktop/projects/axle",
--   name = "axle",
--   dependencies = { "nvim-telescope/telescope.nvim" },
--   config = function()
--     require("axle")
--   end,
-- }
