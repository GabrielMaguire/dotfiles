return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nightfox'

      -- Show end of buffer characters
      vim.api.nvim_set_hl(0, 'EndOfBuffer', { fg = 'grey' })
    end,
  },
  {
    'catppuccin/nvim',
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    -- end,
    name = 'catppuccin',
    opts = {
      color_overrides = {
        mocha = {
          base = '#0A0A0F',
          mantle = '#000000',
          crust = '#11111B',
        },
      },
    },
  },
}
