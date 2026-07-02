-- Absolute paths (or ~-prefixed) of "core" files to inject as cross-file
-- context for FIM completion. Edit this list per-project as needed.
local core_files = {
  '~/dev/castle/base/core.h',
  '~/dev/castle/base/arena.h',
  -- '~/dev/castle/base/str.h',
}

local core_cache = { key = nil, content = nil }

local function build_core_block()
  if #core_files == 0 then
    return ''
  end

  local resolved = {}
  local key_parts = {}
  for _, p in ipairs(core_files) do
    local path = vim.fn.fnamemodify(vim.fn.expand(p), ':p')
    local stat = vim.uv.fs_stat(path)
    if stat then
      table.insert(resolved, path)
      table.insert(key_parts, path .. ':' .. stat.mtime.sec .. ':' .. stat.size)
    end
  end

  local key = table.concat(key_parts, '|')
  if core_cache.key == key and core_cache.content then
    return core_cache.content
  end

  local parts = {}
  for _, path in ipairs(resolved) do
    local f = io.open(path, 'r')
    if f then
      local content = f:read '*a'
      f:close()
      table.insert(parts, '<|file_sep|>' .. vim.fn.fnamemodify(path, ':.') .. '\n' .. content)
    end
  end

  core_cache.key = key
  core_cache.content = #parts > 0 and (table.concat(parts, '\n') .. '\n') or ''
  return core_cache.content
end

local function fim_prompt_with_core(context_before_cursor, _, _)
  local utils = require 'minuet.utils'
  local prefix = utils.add_language_comment() .. '\n' .. utils.add_tab_comment() .. '\n' .. context_before_cursor

  local core = build_core_block()
  if core == '' then
    return prefix
  end

  local current = vim.fn.expand '%:.'
  if current == '' then
    current = 'current'
  end
  return core .. '<|file_sep|>' .. current .. '\n' .. prefix
end

return {
  'milanglacier/minuet-ai.nvim',
  enabled = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'InsertEnter',
  keys = {
    { '<leader>uc', '<cmd>Minuet virtualtext toggle<CR>', desc = 'Toggle AI completions' },
  },
  config = function()
    require('minuet').setup {
      provider = 'openai_fim_compatible',
      n_completions = 1,
      context_window = 16384,
      request_timeout = 5,
      throttle = 1500,
      debounce = 0,

      enable_predicates = {
        function()
          return vim.bo.buftype == ''
        end,
      },

      virtualtext = {
        auto_trigger_ft = { '*' },
        show_on_completion_menu = false,
        keymap = {
          accept = '<Tab>',
          accept_line = '<A-l>',
          accept_n_lines = '<A-z>',
          prev = '<A-[>',
          next = '<A-]>',
          dismiss = '<A-e>',
        },
      },

      provider_options = {
        openai_fim_compatible = {
          -- Ollama doesn't require auth; point at any existing env var.
          api_key = 'TERM',
          name = 'Ollama',
          end_point = 'http://localhost:11434/v1/completions',
          model = 'qwen2.5-coder:7b',
          template = {
            prompt = fim_prompt_with_core,
            suffix = function(_, context_after_cursor, _)
              return context_after_cursor
            end,
          },
          optional = {
            max_tokens = 24,
            top_p = 0.9,
          },
        },
      },
    }
  end,
}
