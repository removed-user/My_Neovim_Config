---@module 'lazy'
---@type LazySpec
return {
  -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  --version = '1.*',
  version = '*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'saghen/blink.compat',
      version = '*',
      --version = '2.*',
      lazy = false,
      opts = {},
    },
    -- Snippet Engine
    {
      lazy = false,
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = 'make install_jsregexp',
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {

    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = true,
    },

    completion = {
      menu = {
        auto_show = true,
      },
      ghost_text = { enabled = true },
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    {
      sources = {
        default = function(ctx) ---@diagnostic disable-line
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and vim.tbl_contains({ 'coment', 'line_comment', 'block_comment' }, node:type()) then
            return { 'buffer' }
          elseif vim.bo.filetype == 'lua' then
            return { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' }
          else
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
        end,
      },
      providers = {
        lsp = {
          name = 'lsp',
          enabled = true,
          module = 'blink.cmp.sources.lsp',
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        path = {
          name = 'path',
          module = 'blink.cmp.sources.path',
        },
        snippets = {
          name = 'snippets',
          module = 'blink.cmp.sources.snippets',
        },
        -- Cmdline sources ~
        buffer = {
          name = 'buffer',
          module = 'blink.cmp.sources.buffer',
        },
        cmdline = {
          name = 'cmdline',
          module = 'blink.cmp.sources.cmdline',
        },
      },
      --
      -- Disabled sources ~
      -- omni (blink.cmp.sources.complete_func)
      ---
      --      sources = {
      --        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      --        providers = {
      --
      --          lazydev = {
      --            name = 'LazyDev',
      --            module = 'lazydev.integrations.blink',
      --            score_offset = 100,
      --          },
      --        },
    },
    --      snippets = { preset = 'default' }, -- 'luasnip'  |

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
-- vim: ts=2 sts=2 sw=2 et
