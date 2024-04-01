return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'cuda',
        'diff',
        'disassembly',
        'dockerfile',
        'doxygen',
        'html',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'python',
        'starlark',
        'tmux',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ['<leader>af'] = '@parameter.inner', -- swap parameters/argument with next
          },
          swap_previous = {
            ['<leader>aF'] = '@parameter.inner', -- swap parameters/argument with prev
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function start' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
          },
        },
      },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      require('nvim-treesitter.configs').setup(opts)

      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- ensure ; goes forward and , goes backward regardless of the last direction
      -- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
      -- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

      -- Repeat movement with ; and ,
      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end,
  },
}
