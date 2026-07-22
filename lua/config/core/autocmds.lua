-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
--vim.api.nvim_set_hl(vim.api)
vim.api.nvim_set_hl(0, 'Visual', {
  bg = '#3e4452',
  fg = '#ffffff',
  bold = true,
})

--[[
 Thought there was a <> mapping for capslock, would have to add keycode check code, not wanting to fuck with it rn

vim.api.nvim_create_autocmd('InsertLeave', {
    desc = 'An AuCmd to automatically turn off caps lock when leaving insert',
  callback = 't',
})
--]]

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Set colorscheme on startup through Autocommands',
  callback = function() vim.cmd 'colorscheme tokyonight-storm' end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- pattern = { "bash", "sh" },
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function() vim.hl.on_yank() end,
-- })
