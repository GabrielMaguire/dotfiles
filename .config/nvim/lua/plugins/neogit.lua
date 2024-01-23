return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>gs",
      function()
        require("neogit").open()
      end,
      desc = "Neogit",
    },
  },
  config = true,
  opts = {
    disable_context_highlighting = true,
    graph_style = "unicode",
  },
}
