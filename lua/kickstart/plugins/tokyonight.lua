return {
  ---@class tokyonight.Config
  ---@field on_colors fun(colors: ColorScheme)
  ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)

  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  main = 'tokyonight',
  name = 'tokyonight',
  -- config = function()
  -- require('tokyonight').setup {
  opts = {
    style = 'storm',
    terminal_colors = true,
    transparent = false,
    styles = {

      comments = { italic = false },
      -- keywords = { italic = false },
      -- functions = {},
      -- variables = {},
      -- sidebars = "dark",
      -- floats = "dark",
    },
    -- dim_inactive = true,
    lualine_bold = true,

    ---@param colors ColorScheme
    -- on_colors = function(colors) end,
    -- on_highlights = function(highlights, colors) end,
    -- on_highlights = function(hl, c)
    --   hl.Visual = {
    --     bg = c.bg_visual,
    --     -- fg = c.none,
    --   }
    -- end,
    cache = true,
    ---@type table<string,boolean|{enabled:boolean}>
    plugins = {
      all = package.loaded.lazy == nil,
      auto = true,
    },
  },
}

-- Load the colorscheme here.
-- Like many other themes, this one has different styles, and you could load
-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
-- end,
-- vim: ts=2 sts=2 sw=2 et
