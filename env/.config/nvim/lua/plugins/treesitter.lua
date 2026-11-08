return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- the `master` branch does NOT support Neovim 0.12+
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'bash',
        'c',
        'cmake',
        'cpp',
        'cuda',
        'diff',
        'disassembly',
        'dockerfile',
        'doxygen',
        'gitcommit',
        'git_config',
        'html',
        'hyprlang',
        'ini',
        'javascript',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline', -- needed for markdown injections (was implicit on master)
        'nix',
        'python',
        'ssh_config',
        'starlark',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      }

      -- Install/update the parsers asynchronously.
      require('nvim-treesitter').install(parsers)

      -- On the `main` branch nothing is enabled automatically: we start
      -- highlighting, folds and indentation ourselves whenever a buffer's
      -- language has a parser available.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('my.treesitter', { clear = true }),
        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
          if not lang then
            return
          end
          -- `language.add` returns false (it does NOT error) when no parser is
          -- available, so we must check its return value, not just pcall it.
          -- This keeps us from calling start() on scratch filetypes such as
          -- blink.cmp's completion menu.
          local ok, added = pcall(vim.treesitter.language.add, lang)
          if not (ok and added) then
            return
          end

          -- Highlighting.
          vim.treesitter.start(buf, lang)

          -- Treesitter-based indentation (experimental on the main branch).
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  { -- Syntax-aware text objects, movement and swapping
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      -- Select
      local select = require('nvim-treesitter-textobjects.select').select_textobject
      local selections = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      }
      for key, query in pairs(selections) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select(query, 'textobjects')
        end)
      end

      -- Swap
      local swap = require 'nvim-treesitter-textobjects.swap'
      vim.keymap.set('n', '<leader>af', function()
        swap.swap_next '@parameter.inner'
      end, { desc = 'Swap parameter with next' })
      vim.keymap.set('n', '<leader>aF', function()
        swap.swap_previous '@parameter.inner'
      end, { desc = 'Swap parameter with previous' })

      -- Move (these register with the repeatable-move system automatically,
      -- so ; and , below repeat them)
      local move = require 'nvim-treesitter-textobjects.move'
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })

      -- Repeat movement with ; and ,
      -- vim way: ; goes to the direction you were moving.
      local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      -- Make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
