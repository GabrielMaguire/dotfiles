return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = { prompt_position = 'top' },
          sorting_strategy = 'ascending',
          winblend = 0,
        },
      }

      -- Provide consistent coloring between telescope and oil
      local palette = require('nightfox.palette').load 'nightfox'
      vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = palette.yellow.base, bold = true })

      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = palette.bg0 })
      vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = palette.bg0 })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = palette.bg0 })

      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = palette.bg0, fg = palette.blue.dim })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = palette.bg0, fg = palette.blue.dim })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = palette.bg0, fg = palette.blue.dim })

      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = palette.blue.dim })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = palette.blue.dim })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = palette.blue.dim })

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>s/', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch [W]ord' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          layout_config = {
            width = 0.5,
          },
        })
      end, { desc = 'Fuzzily search in current buffer' })
    end,
  },
}
