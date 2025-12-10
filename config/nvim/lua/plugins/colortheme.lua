return {
  'shaunsingh/nord.nvim',
  lazy = false,    -- Load immediately
  priority = 1000, -- Load first to set the background
  config = function()
    local theme_path = vim.fn.stdpath("config") .. "/lua/current_theme.lua"
    local f = io.open(theme_path, "r")

    if f then
      f:close()
      local colors = dofile(theme_path)

      vim.api.nvim_set_hl(0, "Normal", { fg = colors.foreground, bg = colors.background })
      vim.api.nvim_set_hl(0, "Cursor", { fg = colors.background, bg = colors.cursor })
      vim.api.nvim_set_hl(0, "Comment", { fg = colors.comment, italic = true })
      vim.api.nvim_set_hl(0, "String", { fg = colors.string })
      vim.api.nvim_set_hl(0, "Function", { fg = colors.function_ })
      vim.api.nvim_set_hl(0, "Keyword", { fg = colors.keyword, bold = true })
      vim.api.nvim_set_hl(0, "Constant", { fg = colors.constant })
      vim.api.nvim_set_hl(0, "Error", { fg = colors.error })
    else
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      require('nord').set()
    end
  end,
}
