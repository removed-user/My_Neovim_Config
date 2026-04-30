local plugin_list = {
  example_plugin = { repo = 'username/plugin.nvim' },
  example_plugin2 = { repo = 'username2/plugin2.nvim' },

  gitsigns = {
    repo = 'lewis6991/gitsigns.nvim',
    main = 'gitsigns',
    require 'kickstart.plugins.gitsigns',
    dependencies = {
      'folke/tokyonight.nvim',
    },
  },
}
local Blueprint = {}
local defaults = {
  enabled = true,
  lazy = true,
  -- Matching and splitting function returns the second part of repo name, split on / and on '.nvim'
  -- This sets main of username/repo.nvim to repo, so all options and config can be tucked away behind their plugin name
  main = function(self) return self.repo and self.repo:match('.*/(.*)'):gsub('%.nvim$', '') or nil end,
}

local function make_plugin_metatable(default_vals)
  return {
    __index = function(current_table, key)
      local plugin_default_key = default_vals[key]

      if type(plugin_default_key) == 'function' then return plugin_default_key(current_table) end

      if type(plugin_default_key) == 'table' then
        local nested = {}
        rawset(table, key, nested)
        setmetatable(nested, make_plugin_metatable(plugin_default_key))
        return nested
      end

      return plugin_default_key
    end,
  }
end
--------------------------------
local function flatten(table)
  local result = {}
  for key, _ in pairs(defaults) do
    local plugin_value = table[key]
    if type(plugin_value) == 'table' then
      result[key] = flatten(plugin_value)
    else
      result[key] = plugin_value
    end
  end

  for key, plugin_value in pairs(table) do
    if result[key] == nil then result[key] = (type(plugin_value) == 'table') and flatten(plugin_value) or plugin_value end
  end
  return result
end

Blueprint.registry = {}
Blueprint.specs = {}
--plugin_specgen.spec = {}
for name, config in pairs(plugin_list) do
  -- Create Smart proxy_table
  local proxy_table = setmetatable(config, make_plugin_metatable(defaults))
  -- Assign the name of the table to the value of the name of the plugins table
  proxy_table.name = name
  -- Save metatable to registry for access
  Blueprint.registry[name] = proxy_table
  -- Flatten for lazy
  local entry = flatten(proxy_table)
  -- Remap index 1
  local repo_val = entry.repo
  -- Wipe index 1, to prevent lazy from being confused
  entry.repo = nil
  --
  table.insert(entry, 1, repo_val)
  table.insert(Blueprint.specs, entry)
end
--return Blueprint.specs,

print '###EVALUATED - TABLE###'
print(vim.inspect(Blueprint.specs))
print '###SEPERATOR###'
print(vim.inspect(Blueprint.registry['name']))
print '###SEPERATOR###'
print(type(Blueprint.specs[1]))
print '###SEPERATOR###'
print(#Blueprint.specs)
print '###SEPERATOR###'
print(#Blueprint.specs[1])
print '###SEPERATOR###'
print(#Blueprint.specs[2])
print '###SEPERATOR###'
print(#Blueprint.specs[3])
print '###SEPERATOR###'
print(#Blueprint.specs[4])
