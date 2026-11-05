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

# Better variant actually doing a thing


```lua
local uv = require('luv')

--- Synchronous system wrapper mimicking vim.fn.system
--- @param cmd table Array containing the executable and its arguments
--- @return string stdout The captured output string
--- @return number code The process exit code
local function system(cmd)
  local stdout_pipe = uv.new_pipe(false)
  local stdout_buffer = {}
  
  -- Deconstruct the command array
  local executable = cmd[1]
  local args = {}
  for i = 2, #cmd do table.insert(args, cmd[i]) end

  -- Spawn the process asynchronously
  local handle, pid_or_err = uv.spawn(executable, {
    args = args,
    stdio = { nil, stdout_pipe, nil } -- Redirect stdout to our pipe
  }, function(code, signal)
    -- On-exit callback: clean up the handle
    uv.close(stdout_pipe)
  end)

  if not handle then
    error("Failed to spawn process: " .. tostring(pid_or_err))
  end

  -- Start reading streaming chunks from stdout into our buffer table
  uv.read_start(stdout_pipe, function(err, data)
    assert(not err, err)
    if data then
      table.insert(stdout_buffer, data)
    else
      -- EOF reached, stop reading
      uv.read_stop(stdout_pipe)
    end
  end)

  -- FORCE THE LOOP TO RUN SYNCHRONOUSLY
  -- This blocks execution of the rest of the Lua script until the process terminates
  uv.run('default')

  -- Aggregate the streaming chunks into one single string
  return table.concat(stdout_buffer), 0
end

-- =============================================================================
-- Usage example matching a standard Neovim bootstrap logic:
-- =============================================================================
print("Cloning repository...")
local output, code = system({
  "git", "clone", "--depth=1", "https://github.com", "/tmp/lazy.nvim"
})

print("Process finished with code: " .. code)
print("Git Output:\n" .. output)
```
