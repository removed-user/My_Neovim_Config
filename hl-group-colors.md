

-- Enable tracking in your Gitsigns setup
require('gitsigns').setup({
  linehl    = true, -- Tracks the full line backgrounds
  word_diff = true, -- Tracks specific words within a line
})


local truly_dim = {
  -- Base color is already dark/muddy, plus 25% transparency
  line_add    = '#233B2640', -- Smoky Dim Green
  line_delete = '#4A232540', -- Smoky Dim Red
  line_change = '#1A2F4C40', -- Smoky Dim Blue
  },
local grayscale_tint = {
  line_add    = '#2D352E33', -- Barely visible green-gray
  line_delete = '#362D2D33', -- Barely visible red-gray
  line_change = '#2D313633', -- Barely visible blue-gray
}



-- Color scheme definition
local diff_colors = {
  -- Full line backgrounds (Dim / Translucent)
  line_add      = '#2ECC7121', -- Dim Green (13% Opacity)
  line_delete   = '#E74C3C21', -- Dim Red (13% Opacity)
  line_change   = '#3498DB21', -- Dim Blue (13% Opacity)

  -- Intra-line Word highlights (Highly Visible)
  word_add      = '#00FF877F', -- Bright Vibrant Green (50% Opacity)
  word_delete   = '#FF4D4D7F', -- Bright Vibrant Red (50% Opacity)
  word_change   = '#00D2FF99', -- Bright Electric Blue (60% Opacity)
}

-- Make the GitSigns line highlights follow primary line highlights
vim.api.nvim_set_hl(0, 'GitSignsAddLn',     { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn',  { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn',  { link = 'DiffChange' })

--[[
Apply full line backgrounds
vim.api.nvim_set_hl(0, 'GitSignsAddLn',    { bg = diff_colors.line_add })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { bg = diff_colors.line_delete })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = diff_colors.line_change })
--]]

-- Apply word-level overrides
-- This makes added words green
vim.api.nvim_set_hl(0, 'GitSignsAddWord',    { bg = diff_colors.word_add }) 
-- This makes text modifications within a changed line bright blue [1]
vim.api.nvim_set_hl(0, 'GitSignsChangeWord', { bg = diff_colors.word_change }) 
-- This keeps deleted word references a bright red
vim.api.nvim_set_hl(0, 'GitSignsDeleteWord', { bg = diff_colors.word_delete })
