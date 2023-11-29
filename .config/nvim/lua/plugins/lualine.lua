return {
  "nvim-lualine/lualine.nvim",
  optional = true,

  -- Remove Aerial integration
  opts = function(_, opts)
    table.remove(opts.sections.lualine_c)
  end,
}
