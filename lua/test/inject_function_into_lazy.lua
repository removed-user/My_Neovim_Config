-- Before calling require("lazy").setup(...)

-- Hook Into Spec Normalization
--[[
If you wrap Spec.normalize...
  - before calling lazy.setup()
  - May be able to inject a function to validate every plugin
--]]


local Spec = require("lazy.core.plugin").Spec
local orig_normalize = Spec.normalize

local function auto_opts(plugin, existing_opts)
  local clean_name = plugin.name:gsub("%.nvim$", ""):gsub("%.lua$", "")
  local ok, loaded_opts = pcall(require, "plugins.configs." .. clean_name)

  if ok and type(loaded_opts) == "table" then
    return vim.tbl_deep_extend("force", existing_opts or {}, loaded_opts)
  end
  return existing_opts or {}
end

Spec.normalize = function(self, spec, ...)
  -- Let lazy.nvim parse the raw spec into standard LazyPlugin entries first
  local result = orig_normalize(self, spec, ...)

  -- Walk the normalized plugins and wrap their `opts`
  for _, plugin in pairs(self.plugins) do
    if not plugin._auto_opts_injected then
      plugin._auto_opts_injected = true
      local user_opts = plugin.opts

      plugin.opts = function(p, opts)
        local base = auto_opts(p, opts)
        if type(user_opts) == "function" then
          return user_opts(p, base) or base
        elseif type(user_opts) == "table" then
          return vim.tbl_deep_extend("force", base, user_opts)
        end
        return base
      end
    end
  end

  return result
end
