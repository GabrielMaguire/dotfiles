local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local conf = require('telescope.config').values

local function split(str)
  local result = {}
  for word in string.gmatch(str, '%S+') do
    table.insert(result, word)
  end
  return result
end

local live_ripgrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  -- opts.prompt_titletitle = opts.title or 'Live Ripgrep'

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        { 'rg' },
        split(prompt),
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = opts.title,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      local pieces = vim.split(prompt, '  ')
      local args = { 'rg' }
      if pieces[1] then
        table.insert(args, '-e')
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, '-g')
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Multi Grep',
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
    })
    :find()
end

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          find_files = {
            layout_config = {
              height = 100,
            },
            find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
          },
          buffers = { sort_mru = true },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
        defaults = require('telescope.themes').get_ivy {
          -- layout_strategy = 'horizontal',
          -- layout_config = { prompt_position = 'top' },
          -- sorting_strategy = 'ascending',
          -- winblend = 0,
          layout_config = { height = 100 },
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

      local builtin = require 'telescope.builtin'

      -- File search
      vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Search files' })

      -- Text search
      vim.keymap.set('n', '<leader>s.', function()
        builtin.live_grep {
          cwd = require('telescope.utils').buffer_dir(),
          prompt_title = 'Live Grep (current dir)',
        }
      end, { desc = 'Live Grep (current dir)' })
      vim.keymap.set('n', '<leader>s/', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch [W]ord' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_ivy())
      end, { desc = 'Fuzzy search in current buffer' })
      vim.keymap.set('n', '<leader>sg', live_multigrep, { desc = 'Multi Grep' })

      -- Misc. search
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    end,
  },
}
