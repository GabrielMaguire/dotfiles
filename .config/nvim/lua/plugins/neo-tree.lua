local Util = require("lazyvim.util")

return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = Util.root(), reveal = true })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    { "<leader>ge", false },
  },
  opts = {
    window = {
      position = "float",

      -- If I want to fullscreen the floating window
      -- popup = {
      --   size = { height = "100%", width = "100%" },
      -- },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
      },
    },
    enable_diagnostics = false,
  },
}
