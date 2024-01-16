return {
  "nvim-lualine/lualine.nvim",
  optional = true,

  opts = function(_, opts)
    -- Remove Aerial integration
    table.remove(opts.sections.lualine_c)

    -- Re-organize sections
    opts.sections.lualine_y = { "progress" }
    opts.sections.lualine_z = { "location" }
  end,
}
