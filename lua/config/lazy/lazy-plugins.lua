-- [[ Configure and install plugins ]]

require('lazy').setup {
  spec = {

    -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`
    { 'NMAC427/guess-indent.nvim', opts = {} },

    -- Refactor for lazy evaluation, proper "spec" setup and options propagation

    --OPTION 1

    -- return {
    --  'repo/plugin',
    --  opts = {
    --    option = true,
    --   },
    --  }

    --OPTION 2
    -- Also shows acceptable version overrides for { version = "*"} -- and usage of main for ovrriding reference name

    -- return {
    --  'repo/plugin',
    --  main = "plugin",
    --  version = false, branch = develop commit = "cniod1", pin = true,
    --  opts = require('dir.name')
    --  }

    --OPTION 2

    --  You have total control over the spec here, but its more complicated.
    --
    -- return {
    --  'repo/plugin',
    --  config = function()
    --  local options = require('dir.name')
    --  require("plugin").setup(options)
    --
    -- You can also add arbitrary logic here
    -- print('plugin "name" loaded')
    --  end,
    --  }

    -- modular approach: using `require 'path.name'` will

    require 'config.lazy.lazydev',

    require 'kickstart.plugins.gitsigns',

    require 'kickstart.plugins.which-key',

    require 'kickstart.plugins.telescope',

    require 'lspconfig.lspconfig',

    require 'kickstart.plugins.conform',

    require 'kickstart.plugins.tokyonight',

    require 'kickstart.plugins.todo-comments',

    require 'kickstart.plugins.mini',

    require 'kickstart.plugins.treesitter',

    require 'lspconfig.blink-cmp',

    require 'lspconfig.none-ls',
    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    require 'kickstart.plugins.lint',
    require 'kickstart.plugins.autopairs',
    require 'kickstart.plugins.neo-tree',
    require 'lspconfig.tree_sitter_manager',

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
  { ---@diagnostic disable-line: missing-fields
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
