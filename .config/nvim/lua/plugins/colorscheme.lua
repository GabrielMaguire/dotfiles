return {
  {
    'EdenEast/nightfox.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nightfox'
    end,
    opts = {
      palettes = {
        nightfox = {
          bg0 = '#1c1c1c',
          bg1 = '#262626',
          bg2 = '#303030',
          bg3 = '#3a3a3a',
          bg4 = '#4e4e4e',
        },
      },
    },
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
