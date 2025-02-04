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
    log_level = vim.log.levels.DEBUG,
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
      bzl = { 'buildifier' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      css = { 'prettier' },
      go = { 'golines' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'isort', 'black' },
      sh = { 'shfmt' },
      templ = { 'templ' },
    },
  },
}
