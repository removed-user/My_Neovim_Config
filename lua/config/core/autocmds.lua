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

-- #FIXME
-- vim.api.nvim_create_autocmd('VimEnter', {
--   desc = 'Set colorscheme on startup through Autocommands',
--   callback = function() vim.cmd 'colorscheme tokyonight-storm' end,
-- })

-- vim.api.nvim_create_autocmd('FileType', {
-- pattern = { "bash", "sh" },
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function() vim.hl.on_yank() end,
-- })





--[[
When nvim is resized, automatically resize all open windows

This is a good example of code to put in the plugin folder
given there are no other dependencies or ordering constraints

`autocommands` specify commands to be executed when certain events happen
to see all the events that can happen see `:help events`

`autogroups` allow us to group 1 or more autocommands together
this is especially useful if we wanted to clear some autocommands
with a group we could just delete the group and they all would be gone
-- ]]
local window_group = vim.api.nvim_create_augroup("WindowGroup", { clear = true })

-- on resize even out all the splits no matter what files we have open
vim.api.nvim_create_autocmd("VimResized", { pattern = "*", group = window_group, command = [[exe "normal! \<c-w>=" ]]})
