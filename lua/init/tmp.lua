-- setmetatable on runtime/rtp
local lazy = require("init.lazy")

local function add_setting(tbl, key, value)
  tbl[key] = value
end

local function setup_rtp()
  local runtime = {}

  -- Adds key = value to runtime
  add_setting(runtime, "lazypath", vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  -- Or using your module variable:
  -- add_setting(runtime, "lazypath", lazy.lazypath)

  -- Metatable to turn the key = value entries into a numbered list for vim.opt.rtp
  setmetatable(runtime, {
    __call = function(tbl)
      local list = {}
      local count = 0
      for _, value in pairs(tbl) do
        count = count + 1
        list[count] = value
      end
      return list
    end,
  })

  vim.opt.rtp = runtime()
  return runtime
end

return {
  setup_rtp = setup_rtp,
}


-- Validator functions

local function validate_plugin_spec(plugin_spec)
  if type(plugin_spec) ~= "table" then
    return false, "Plugin file did not return a table"
  end

  -- Check if it's a single spec { "user/repo", ... } vs a list of specs { { ... }, { ... } }
  if type(plugin_spec[1]) == "string" or plugin_spec.dir or plugin_spec.import then
    -- Validate single spec properties (e.g., plugin_spec.opts, plugin_spec.config)
    if plugin_spec.opts ~= nil and type(plugin_spec.opts) ~= "table" and type(plugin_spec.opts) ~= "function" then
      return false, "Invalid opts type in " .. tostring(plugin_spec[1])
    end
  elseif type(plugin_spec[1]) == "table" then
    -- Recursively validate each nested spec in the list
    for _, sub_spec in ipairs(plugin_spec) do
      local ok, err = validate_plugin_spec(sub_spec)
      if not ok then return false, err end
    end
  else
    return false, "Missing plugin repository string or dir"
  end

  return true
end
