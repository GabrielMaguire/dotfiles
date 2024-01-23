return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function()
      local gs = package.loaded.gitsigns
      vim.keymap.set("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame Line" })
    end,
  },
}
