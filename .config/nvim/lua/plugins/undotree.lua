return {
  'mbbill/undotree',
  keys = {
    {
      '<leader>u',
      vim.cmd.UndotreeToggle,
      mode = { 'n', 'v' },
      desc = 'Undo tree',
    },
  },
  init = function()
    vim.g.undotree_SetFocusWhenToggle = true
  end,
}
