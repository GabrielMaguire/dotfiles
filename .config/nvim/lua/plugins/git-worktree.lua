return {
  "ThePrimeagen/git-worktree.nvim",
  enabled = false,
  config = function()
    require("git-worktree").setup({})
    require("telescope").load_extension("git_worktree")
  end,
  keys = {
    {
      "<leader>gw",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "Switch Worktree",
    },
    {
      "<leader>gW",
      function()
        require("telescope").extensions.git_worktree.create_git_worktree()
      end,
      desc = "Create Worktree",
    },
  },
}
