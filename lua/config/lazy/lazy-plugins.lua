-- [[ Configure and install plugins ]]

--[[
 NOTE:
 possible keys 
  'plugin/repo'
--]]

---@diagnostic disable: unused-local
---@diagnostic disable: unused-function

-- local function finalize_spec(plugins)
--   for _, plugin in ipairs(plugins) do
--     if type(plugin.opts) == 'string' then
--       local path = plugin.opts
--       plugin.opts = function() return require(path) end
--     end
--   end
--
--   return plugins
-- end

--[[ Refactor for lazy evaluation, proper "spec" setup and options propagation

    OPTION 1
Messy
     return {
      'repo/plugin',
      opts = {
        option = true,
       },
      }

    OPTION 2
     Also shows acceptable version overrides for { version = "*"} -- and usage of main for ovrriding reference name

     return {
      'repo/plugin',
      main = "plugin",
      version = false, branch = develop commit = "cniod1", pin = true,
      opts = require('dir.name')
      }

    OPTION 2
      You have total control over the spec here, but its more complicated.

     return {
      'repo/plugin',
      config = function()
      local options = require('dir.name')
      require("plugin").setup(options)

     You can also add arbitrary logic here
     print('plugin "name" loaded')
      end,
     }
 --]]
require('lazy').setup {
  spec = {
    --    require 'config.lazy.lazytables',
    -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
    { 'NMAC427/guess-indent.nvim', opts = {} },
    { 'brenoprata10/nvim-highlight-colors', opts = require 'config.colors.nvim-highlight-colors' },

    { 'norcalli/nvim-colorizer.lua', opts = {} },
    { 'rafcamlet/nvim-luapad' },
    {
      'mfussenegger/nvim-lint',
      opts = { require 'kickstart.plugins.lint' },
      main = 'lint',
    },
    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    -- require 'kickstart.plugins.debug',

    --kickstart/plugins/debug
    -- Manual
    --kickstart/plugins/neo-tree
    require 'kickstart.plugins.neo-tree',
    --kickstart/plugins/telescope
    require 'kickstart.plugins.telescope',
    --kickstart/plugins/mini
    require 'kickstart.plugins.mini',
    --kickstart/plugins/which-key
    require 'kickstart.plugins.which-key',

    -- Visuals/Theme
    --kickstart/plugins/tokyonight
    require 'kickstart.plugins.tokyonight',
    --kickstart/plugins/todo-comments
    require 'kickstart.plugins.todo-comments',

    {
      'lewis6991/gitsigns.nvim',
      main = 'gitsigns',
      dependencies = {
        'folke/tokyonight.nvim',
      },
      config = function()
        local options = require 'kickstart.plugins.gitsigns'
        require('gitsigns').setup(options.opts)
      end,
    },
    --   --kickstart/plugins/gitsigns
    --   require 'kickstart.plugins.gitsigns',

    -- -Formatting
    --  kickstart/plugins/conform
    require 'kickstart.plugins.conform',
    --  kickstart/plugins/lint

    require 'kickstart.plugins.lint',
    --  kickstart/plugins/indent_line
    -- require 'kickstart.plugins.indent_line',
    --kickstart/plugins/autopairs
    require 'kickstart.plugins.autopairs',

    -- intelligence
    --   -LSPConfig
    require 'intelligence.lspconfig.lspconfig',
    require 'intelligence.lspconfig.blink-cmp',
    --   -Tresitter
    require 'intelligence.lspconfig.treesitter',
    require 'intelligence.lspconfig.tree_sitter_manager',
    --   -Lang_Specs
    require 'config.lazy.lazydev',
    require 'intelligence.lspconfig.none-ls',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    -- Loads a whole dir of plugins lua/custom/plugins/*.lua
    -- { import = 'custom.plugins' },
    --
    -- More on loading plugins :help lazy.nvim-🔌-plugin-spec
    --
    -- Or use telescope!
    -- <leader>sh lazy.nvim-plugin
    --
    -- <leader>sr resumes last search
  },
  {
    --[[
---@diagnostic disable-line: missing-fields
    --]]
    disabled_plugins = {
      -- "gzip",
      -- "matchit",
      -- "matchparen",
      -- "netrwPlugin",
      -- "tarPlugin",
      'tohtml',
      -- "tutor",
      -- "zipPlugin",
      'compiler',
      'bugreport',
    },
    --[[
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      }, 
    },
  },
--]]

    defaults = { lazy = true },
    install = {
      colorscheme = { 'tokyonight-storm' },
    },
    require = true,
    ui = {
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
