> Example metatable to refer to luv bindings using their vim.uv counterparts

This isn't actually sensible... but - 
serves as a reminder to myself - 
To eventually have a neovim-bootstrap tool/lib in pure lua, which...
- installs necessary lua libraries. 
- Configures the environment
- downloads and/or builds an image with desired flags
- clones my configuration


```lua
-- Assume 'luv' is required in your standalone environment
local luv = require('luv')

-- Create a mock 'vim' global for your bootstrap script
_G.vim = _G.vim or {}

_G.vim.uv = setmetatable({}, {
  __index = function(_, key)
    -- 1. Direct match (e.g., if luv has the exact same name)
    if luv[key] then return luv[key] end
    
    -- 2. Strip Neovim's potential 'uv_' prefix or handle naming drift
    -- (Most luv functions drop the 'uv_' prefix from C, e.g., uv_fs_stat -> luv.fs_stat)
    local stripped_key = key:gsub("^uv_", "")
    if luv[stripped_key] then return luv[stripped_key] end
    error("Function " .. key .. " not found in standard luv library.")
  end
})

local stat = vim.uv.fs_stat("some/path") 
```
