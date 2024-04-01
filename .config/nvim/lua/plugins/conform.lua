return {
  'stevearc/conform.nvim',
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { timeout_ms = 3000 }
      end,
      mode = { 'n', 'v' },
      desc = 'Format code',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
      bzl = { 'buildifier' },
      lua = { 'stylua' },
      python = { 'black' },
    },
  },
}
