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
