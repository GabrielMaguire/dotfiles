return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      section_separators = '',
      component_separators = '│',
      disabled_filetypes = { 'undotree' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'branch', icon = '' },
        'diff',
        'diagnostics',
      },
      lualine_c = { { 'filename', path = 3, color = { fg = 'grey' } } },
      lualine_x = { { 'filetype' } },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
