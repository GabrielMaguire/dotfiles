return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nightfox'
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
