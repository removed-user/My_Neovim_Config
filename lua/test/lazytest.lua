--[[
 NOTE:
 Possible Keys 

  -- Essential/Core

 [1] 'plugin/repo'; must be index 1
 dir = path to local plugin directory to use instead of a repo
 url = way to override the default git repo Url
 name = override the default plugin name, (usually name from github_repo:username/$name )

-- Lazy Loading Behaviour
lazy = true/false
enabled true/false
event = string, list indicating autocmds that should trigger the plugin
cmd = list of cmds that load the plugin
ft = string, list of filetypes to load on 
keys = a list, string, or table of keys that load the plugin

-- Config and Intitialization of the plugin
init = function that runs on nvim startup
config = function that runs on plugin startup
opts = table or function returning a table of options to pass to the plugins setup 
opts_extend = defines tables that will be merged for the opts
main = can be set to a module name to use that module for the opts or config key 

-- Dependencies and lifecycle Management
Dependencies = a table of plugins that this plugin depends on, and/or should always be loaded before this one
build = cmd or function to run when plugin is installed
branch = particular git branch as source
commit = particular git commit as source
tag =    particular git tag as source
init = 
--]]

--[[
---@diagnostic disable: unused-local
---@diagnostic disable: unused-function
local function finalize_spec(plugins)
  for _, plugin in ipairs(plugins) do
    if type(plugin.opts) == 'string' then
      local path = plugin.opts
      plugin.opts = function() return require(path) end
    end
  end

  return plugins
end

--]]
--[[
local raw = {
  { example_plugin = 'username/plugin' },
}
local function evaluate_plugin(raw)
  local final = {}
  final[1] = raw.repo

  for k, v in pairs(raw) do
    if k ~= 'repo' then
      if k == 'opts' and type(v) == 'string' then
        final[k] = require(v)
      else
        final[k] = (type(v) == 'function') and v() or v
      end
    end
  end
  return final
end
local result = evaluate_plugin(plugin_pre)
--]]
-- print '###EVALUATED - TABLE###'
-- print(vim.inspect(result))

--[[
-- function to lazy setup a plugin and require its configuration file 
config = function(_, opts)
require(plugin_path).setup(opts)
end,
--]]

----------------------------------------------------------------------------------------------------------

--[[
Matching and splitting function returns the second part of repo name
split on / and on '.nvim'
This sets main of username/repo.nvim to repo
So all options and config can be set behind their plugin name
  --]]

local defaults = {
  enabled = true,
  lazy = true,
  main = function(self) return self.repo and self.repo:match('.*/(.*)"'):gsub('%.nvim$', '') or nil end,
  --config_path = function(self) return self.conf_path or

  --  local status_ok, self.name
  config = function(self)
    if not self.config_path then print('config_path for plugin:', self.main, 'is not listed') end
    return function(_, opts) require(self.conf_path).setup(opts) end
  end,
}

local plugin_list = {
  example_plugin = { dir = 'username/plugin.nvim', enabled = false },
  example_plugin2 = { dir = 'username2/plugin2.nvim', enabled = false },

  gitsigns = {
    repo = 'lewis6991/gitsigns.nvim',
    main = 'gitsigns',
    config_path = 'kickstart.plugins.gitsigns',
    --opts = require 'kickstart.plugins.gitsigns',
    dependencies = {
      'folke/tokyonight.nvim',
    },
  },
  {
    'mfussenegger/nvim-lint',
    main = 'lint',
    config_path = require 'kickstart.plugins.lint',
  },
}

local Blueprint = {}

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
-- return Blueprint.specs

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
--print(#Blueprint.specs[4])

--     --kickstart.plugins.debug
--     -- Manual
--     require 'kickstart.plugins.neo-tree',
--     require 'kickstart.plugins.telescope',
--     require 'kickstart.plugins.mini',
--     require 'kickstart.plugins.which-key',

--     -- Visuals/Theme
--     require 'kickstart.plugins.tokyonight',
--     require 'kickstart.plugins.todo-comments',
--     require 'kickstart.plugins.gitsigns',
--
--     -- -Formatting
--     require 'kickstart.plugins.conform',
--     require 'kickstart.plugins.lint',
--     require 'kickstart.plugins.indent_line',
--     require 'kickstart.plugins.autopairs',
--
--     -- intelligence
--     --   -LSPConfig
--     require 'intelligence.lspconfig.lspconfig',
--     require 'intelligence.lspconfig.blink-cmp',
--     --   -Tresitter
--     require 'intelligence.lspconfig.treesitter',
--     require 'intelligence.lspconfig.tree_sitter_manager',
--     --   -Lang_Specs
--     require 'config.lazy.lazydev',
--     require 'intelligence.lspconfig.none-ls',
-- ###################################################################

-- kickstart/plugins/debug.lua
--
-- Manual
--     kickstart/plugins/neo-tree.lua
--     kickstart/plugins/telescope.lua
--     kickstart/plugins/mini.lua
--     kickstart/plugins/which-key.lua.lua

-- Visuals/Theme
--     kickstart/plugins/tokyonight.lua
--     kickstart/plugins/todo-comments.lua
--     kickstart/plugins/gitsigns.lua.lua

-- Formatting
--     kickstart/plugins/conform.lua
--     kickstart/plugins/lint.lua
--     kickstart/plugins/indent_line.lua
--     kickstart/plugins/autopairs.lua

-- intelligence
--  LSPConfig
--     intelligence/lspconfig/lspconfig.lua
--     intelligence/lspconfig/blink-cmp.lua
--  Tresitter
--     intelligence/lspconfig/treesitter.lua
--     intelligence/lspconfig/tree_sitter_manager.lua
--  Lang_Specs
--     config/lazy/lazydev.lua
--     intelligence/lspconfig/none-ls.lua
-- [[
-- M.config = {}
-- setmetatable(M.config, make_plugin_metatable(defaults))
-- return M
--]]
