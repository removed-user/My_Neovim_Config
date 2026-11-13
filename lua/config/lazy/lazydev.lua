return {
{ "LuaCATS/ffi-reflect", name = "ffi-reflect", lazy = true },
{ "LuaCATS/luassert", name = "luassert", lazy = true },
{ "LuaCATS/busted", name = "busted", lazy = true },
{ "LuaCATS/luv", name = "luv", lazy = true },
{ "LuaCATS/lfs", name = "lfs", lazy = true },  
  {
    'folke/lazydev.nvim',
    -- only load on lua files
    ft = 'lua',
    opts = {

integrations = {
    -- Fixes vim.lsp.config workspace management for LuaLS
    -- Only create a new workspace if the buffer is not part
    -- of an existing workspace or one of its libraries.
    -- Only works on Neovim 0.11+.
    lspconfig = true,
    -- add the cmp source for completion of:
    -- `require "modname"`
    -- `---@module "modname"`
    cmp = true,
    -- same, but for Coq
    coq = true,
  },
      library = {
      { path = 'luv/library', words = { 'vim%.uv' } },
      { path = 'busted/library', words = { 'describe' } },
      { path = "luassert/library", words = { "assert" } },
      { path = "lfs/library", mods = { "lfs" }, words = { "lfs%." } },
      { path = "ffi-reflect/library", mods = { "reflect", "ffi-reflect", "ffi_reflect" }, words = { "reflect%.typeof", "reflect%.getmetatable" } }, 
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
