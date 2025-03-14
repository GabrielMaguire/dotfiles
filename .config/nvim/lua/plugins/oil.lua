-- Hijack netrw to show floating oil window on startup. Taken from:
-- https://github.com/gonstoll/dotfiles/blob/a425ac147b385aad24db95fb4f062130480a5fe0/nvim/lua/plugins/oil.lua#L14
local hijack_netrw = function()
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
end

return {
  'stevearc/oil.nvim',
  opts = {
    -- Set to "false" for oil.nvim netrw hijacking
    -- default_file_explorer = false,
    default_file_explorer = true,

    -- float = {
    --   padding = 2, -- less than 2 leads to a buggy preview window
    --   preview_split = 'right',
    -- },

    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },

    -- Overriden default keymaps
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['gs'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['gv'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['gl'] = { 'actions.refresh', desc = 'Open the entry in a horizontal split' },
      ['go'] = { 'actions.change_sort', mode = 'n', desc = 'Change the sort order' },
      ['g\\'] = false,
    },
  },

  -- Uncomment for proper floating window
  -- init = hijack_netrw,

  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
