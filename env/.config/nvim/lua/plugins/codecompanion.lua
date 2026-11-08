return {
  enabled = false,
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  cmd = 'CodeCompanion', -- Load the plugin when the command is called
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = 'anthropic',
      },
      inline = {
        adapter = 'anthropic',
      },
    },
    opts = {
      -- Set debug logging
      -- log_level = 'TRACE',
    },
  },
  keys = {
    {
      '<leader>ai',
      function()
        vim.cmd('CodeCompanion ' .. vim.fn.input { prompt = 'Prompt: ' })
      end,
      mode = { 'n', 'v' },
      desc = 'Code companion chat',
    },
    {
      '<leader>ti',
      function()
        require('codecompanion').toggle()
      end,
      desc = 'Code companion chat',
    },
    {
      '<leader>si',
      function()
        require('codecompanion').actions()
      end,
      desc = 'Code companion chat',
    },
  },
}
