return {
  'stevearc/oil.nvim',
  opts = {
    -- Required to override oil.nvim netrw hijacking
    default_file_explorer = false,

    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 4,
      max_width = 100,
      min_width = 40,
    },
  },

  -- Hijack netrw to show floating oil window on startup. Taken from:
  -- https://github.com/gonstoll/dotfiles/blob/a425ac147b385aad24db95fb4f062130480a5fe0/nvim/lua/plugins/oil.lua#L14
  init = function()
    local netrw_bufname

    pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
    vim.api.nvim_create_autocmd('VimEnter', {
      pattern = '*',
      once = true,
      callback = function()
        pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
      end,
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('oil.nvim', { clear = true }),
      pattern = '*',
      callback = function()
        vim.schedule(function()
          if vim.bo[0].filetype == 'netrw' then
            return
          end
          local bufname = vim.api.nvim_buf_get_name(0)
          if vim.fn.isdirectory(bufname) == 0 then
            _, netrw_bufname = pcall(vim.fn.expand, '#:p:h')
            return
          end
          -- prevents reopening of file-browser if exiting without selecting a file
          if netrw_bufname == bufname then
            netrw_bufname = nil
            return
          else
            netrw_bufname = bufname
          end
          -- ensure no buffers remain with the directory name
          vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
          require('oil').open_float()
        end)
      end,
      desc = 'oil.nvim replacement for netrw',
    })
  end,
  -- End netrw hijacking.

  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
