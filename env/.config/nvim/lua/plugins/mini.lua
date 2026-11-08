return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.pairs').setup()

      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 200 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Add quotes around WORD in normal mode
      vim.keymap.set('n', '<leader>q', function()
        vim.cmd 'normal saiW"'
      end, { desc = '[Q]uote WORD' })

      -- Add quotes around selection in visual mode
      vim.keymap.set('v', '<leader>q', function()
        vim.cmd 'normal sa"'
      end, { desc = '[Q]uote selection' })
    end,
  },
}
