--@type lua
--[[
### Extended marks (extmarks)
extmarks track text changes in the buffer.

BufEnter
BufLeave


      nvim_create_augroup()
nvim_create_autocmd({event}, {opts})
    Creates an autocommand event handler, defined by `callback` or `command`

        vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        --pattern = {'*.c', '*.h'},
          callback = function(ev)
            print(string.format('event fired: %s', vim.inspect(ev)))
          end
        })

nvim_buf_set_extmark(
{buffer},
{ns_id},
{line},
{col},
{*opts}
)

col
-— extmark start coords
line,
-— other/extra options for extmark
opts

CMD example
highlight default MyHighlight guifg=#ff007c gui=bold ctermfg=198 cterm=bold ctermbg=darkgreen
local end_col = <your value here>
local start_col = 0 --for readability

vim.api.nvim_buf_set_extmark(
buffer_id,
namespace_id,
line_number - 1,
start_col,
{end_row = line_number - 1,
end_col = end_col,
hl_group='MyHighlight'
})
--]]

local Highlight_Selected_Text = {}

local current_mode = vim.api.nvim_get_mode().mode
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*:*',
  callback = function() current_mode = vim.api.nvim_get_mode().mode end,
})
function get_current_mode() print('The current_mode is:' .. current_mode)
 end
print(vim.inspect(get_current_mode))
print(Highlight_Selected_Text)

-- function Highlight_Selected_Text.run_autocommands()
--    vim.api.nvim_command('augroup HighlightLine')
--    vim.api.nvim_command('autocmd!')
--    vim.api.nvim_command("autocmd ColorScheme * lua require'highlights'.init_highlights()")
--    vim.api.nvim_command('augroup end')
-- end

-- dynamic highlighting logic
function Highlight_Selected_Text.highlight()
end



local function init_highlights()
  namespace_id = vim.api.nvim_create_namespace 'Highlight_Selected_Text'
  vim.api.nvim_command 'highlight default HighlightLine guifg=#ff007c gui=bold ctermfg=198 cterm=bold ctermbg=darkgreen'
end
--both of these will be invalidated on change; ie current is no longer current
local current_window = vim.api.nvim_get_current_win()
local current_buffer = vim.api.nvim_get_current_buf()

-- mkpoll; actrually scratch that and hook the kickstart poll

local pos = vim.api.nvim_win_get_cursor(current_window)
local row = pos[1] -- 1 -- zero-based
local col = pos[2]
local current_line = vim.api.nvim_buf_get_lines(current_buffer, row, row + 1, false)[1]
local end_col = function() string.len(current_line) return

-- Using coordinates
vim.api.nvim_buf_set_extmark(current_buffer, namespace_id, row, start_col, {
  end_row = row,
--  end_col = end_col,
  hl_group = 'HighlightLine',
})

-- lua require'highline'.init_highlights()
-- lua require'highline'.run_autocommands()
-- command! Highline lua require'highline'.highlight()<CR>

-- This will create the highlight on the startup of your editor, with init autocommands
-- +bind line-highlight call to `:Highline`

--]]
