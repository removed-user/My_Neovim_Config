--Let me choose a style for our plugin:

```lua
--guifg=#ff007c gui=bold ctermfg=198 cterm=bold ctermbg=darkgreen
```
--[[
### Extended marks (extmarks)

> Extended marks (extmarks) represent buffer annotations that track text changes in the buffer.

 Extmark will be used to annotate a specific piece of text with some metadata such as a highlighting group name. Based on this Neovim will change the style of your piece of text.

Here is Lua Neovim API for creating an extmark:
--]]
nvim_buf_set_extmark({buffer}, {ns_id}, {line}, {col}, {*opts})

Where:

-   **_buffer_** — number of buffer extmark will be applied for
-   **_ns_id_** — id of the namespace (extmarks are bounded to the namespaces)
-   **_line_**, **_col_** — coordinates of the extmark start position
-   **_opts_** — other options. **_end_row_** and **_end_col_** may be passed there
--]]
`nvim_create_namespace({name})`
--[[
Finally let’s get our hands dirty and highlight some text with the Neovim commands!

### How to execute commands

Most straightforward way to accomplish it by exploring Neovim’s command line. While using Vim’s normal mode type in `:` (colon) and then an actual command: you will see it at the bottom side of the terminal, just above the status line.

Press enter or click to view image in full size

Neovim command line

### Highlights in Action

Open any text file with Neovim (e.g. by executing `nvim <file_name>` in a terminal) and make sure the file is not empty, otherwise you won’t see how the magic happens! Then follow by executing the commands one-by-one. To create a **_highlight_**:
--]]
:highlight default MyHighlight guifg=#ff007c gui=bold ctermfg=198 cterm=bold ctermbg=darkgreen

-- After creating namespace we should receive back its id and then assign it to a variable. The same for the current buffer, both of them are needed for creating an **_extmark_**:

:lua namespace_id=vim.api.nvim_create_namespace('MyNamespace')

-- For the buffer:

buffer_id=vim.api.nvim_get_current_buf()
--[[
If you’ve opened fresh Neovim editor, most probably your buffer id is `1`.

Next, you need to find a piece of text as a candidate for highlighting. Please note the line number (to make line numbers visible you may execute `:set number`) and width. Let’s save these into the variables:
--]]
:lua line_number = <your value here>
:lua end_col = <your value here>
:lua start_col = 0 --for readability

-- Finally, after setting the extmark up our text should be highlighted!
:lua vim.api.nvim_buf_set_extmark(buffer_id, namespace_id, line_number - 1, start_col, {end_row = line_number - 1,end_col = end_col, hl_group='MyHighlight'})
--[[
You should see something like this:

Press enter or click to view image in full size

### Wrapping up into a plugin

The fact that by executing several commands you can highlight anything you want is very useful but, for sure, doing it that way is tedious (unless you believe you are a cool hacker, who loves typing Neovim commands). The most common way to overcome this is to wrap you code into plugin, make it load automatically on vim startup and bind this highlighting magic to the single command or keystroke. So, let’s bring our small plugin to life!

I will not touch the basics of creating a Lua plugins with Neovim (if you are curious, check [this](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/) article for more details), so let’s just dive into the actual coding.

In your Neovim configuration directory (for Linux/MacOS it should be `~/.config/nvim` ) find or create directory `lua` with a `highline.lua` file inside.

Usually plugins are started by creating a module and then they are filled in with functions and variables we need to export:
--]]
-- local M = {}
-- -- module content will be here
-- return M

-- Let’s populate the module with a bunch of useful functions. To start with we should create a highlight and create a namespace:

function M.init_highlights()
  vim.api.nvim_command('highlight default HighlightLine guifg=#ff007c gui=bold ctermfg=198 cterm=bold ctermbg=darkgreen')
  namespace_id = vim.api.nvim_create_namespace('HihglightLineNamespace')
end

-- Just to make this highlighting work automatically I will use **_autocommands_** Neovim feature
-- Basic highlighting should work without this, but to make plugin work consistently, it’s better to use this snippet of code

-- function M.run_autocommands()
--    vim.api.nvim_command('augroup HighlightLine')
--    vim.api.nvim_command('autocmd!')
--    vim.api.nvim_command("autocmd ColorScheme * lua require'highlights'.init_highlights()")
--    vim.api.nvim_command('augroup end')
-- end

  -- dynamic highlighting logic is here
function M.highlight()

end

--First, we need to fetch the current window’s and buffer’s ids:

local current_win = vim.api.nvim_get_current_win()
local current_buf = vim.api.nvim_get_current_buf()

-- Then, to fetch highlighting coordinates current cursor position and length of the current line should be store into a variables:


local pos = vim.api.nvim_win_get_cursor(current_win)
local row = pos[1] - 1 -- zero-based
local col = pos[2]local current_line = vim.api.nvim_buf_get_lines(current_buf, row, row + 1, false)[1]
local end_col = string.len(current_line)

-- Finally, we have all the data to be able to perform the actual highlighting.
-- Using coordinates from above let’s use
`nvim_buf_set_extmark`

vim.api.nvim_buf_set_extmark(current_buf, namespace_id, row, start_col, {end_row = row, end_col = end_col, hl_group='HighlightLine'})

-- That’s it, our plugin is almost ready-to-use. In order to load the plugin on startup and set a binding to a meaningful command, add the following lines into the new file under `~/.config/plugin/highline.vim`:

-- lua require'highline'.init_highlights()
-- lua require'highline'.run_autocommands()
-- command! Highline lua require'highline'.highlight()<CR>

-- This will create the highlight on the startup of your editor, init autocommands and bind line-highlight call to `:Highline` command. Navigate to any line at your Neovim’s current buffer and type the `:Highline` command. See it in action:

--]]
