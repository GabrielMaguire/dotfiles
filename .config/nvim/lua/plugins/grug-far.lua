return {
  'MagicDuck/grug-far.nvim',
  opts = {
    keymaps = {
      qflist = { n = '<C-q>' },
      close = { n = '<C-c>' },
    },
  },
  keys = {
    {
      '<leader>sg',
      function()
        require('grug-far').open {}
      end,
      mode = { 'n', 'x' },
      { desc = 'grug-far: Search within range' },
    },
  },
}
