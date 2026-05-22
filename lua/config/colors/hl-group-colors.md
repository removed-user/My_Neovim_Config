

-- Enable tracking in your Gitsigns setup
require('gitsigns').setup({
  linehl    = true, -- Tracks the full line backgrounds
  word_diff = true, -- Tracks specific words within a line
})





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

Smoky_Dim_Green = '#233B2640', -- Smoky_Dim_Green
Smoky_Dim_Red   = '#4A232540', -- Smoky_Dim_Red
Smoky_Dim_Blue  = '#1A2F4C40', -- Smoky_Dim_Blue
  Barely_visible_green-gray = '#2D352E33', -- Barely_visible_green-gray
  Barely_visible_red-gray  = '#362D2D33', -- Barely_visible_red-gray
  Barely_visible_blue-gray = '#2D313633', -- Barely_visible_blue-gray
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
