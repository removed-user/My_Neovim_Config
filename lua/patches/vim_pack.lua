-- shim: keeps existing lazy.nvim config 100% untouched
-- and transparently routes any rogue vim.pack calls into lazy.nvim
local vimpack_queue = {}

vim.pack = setmetatable({
  add = function(specs, opts)
    specs = type(specs) == "string" and { specs } or specs
    for _, s in ipairs(specs) do
      local src = type(s) == "string" and s or s.src
      if src then
        table.insert(_vimpack_queue, {
          src,
          name = type(s) == "table" and s.name or nil,
          version = type(s) == "table" and s.version or nil,
          lazy = opts and opts.load == false or nil,
        })
      end
    end
  end,
}, {
  -- Any calls to update, del, get, etc. become harmless no-ops
  __index = function()
    return function() end
  end,
})
return vimpack_queue
